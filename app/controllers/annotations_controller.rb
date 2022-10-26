class AnnotationsController < ApplicationController
  #load_and_authorize_resource
  respond_to :json
  before_action :ensure_current_user

  #Corresponds to the "Annotation" model, Annotation.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the Annotation model
  # All .html.slim views for "annotation.rb" are located at "project_root\app\views\annotations"
  # GET /annotations
  # GET /annotations.json
  def index
    #@annotations is the variable containing all instances of the "annotation.rb" model passed to the annotation view "index.html.slim" (project_root/annotations) and is used to populate the page with information about each annotation using @annotations.each (an iterative loop).
    if params[:transcription_id]
      @annotations = Annotation
                      .where(transcription_id: params[:transcription_id])
                      .includes(
                          {
                            field_group: [
                              {
                                fields: [
                                  :translations,
                                  :field_options
                                ]
                              },
                              :translations
                            ]
                          },
                          :data_entries
                        )
    else
      @annotations = Annotation
                      .includes(
                          {
                            field_group: [
                              {
                                fields: [:translations, :field_options]
                              },
                              :translations
                            ]
                          },
                          :data_entries
                        )
    end

    respond_to do |format|
      format.html # index.html.slim
      format.json
    end
  rescue => ex
    Rails.logger.error ex.message
    Rails.logger.error ex.backtrace.join('\n\t')
    render json: {status: :bad_request, text: ex.message}
  end

  # GET /annotations/annotation_id
  # GET /annotations/annotation_id.json
  def show
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "show.html.slim" (project_root/annotations/annotation_id) and is used to populate the page with information about the annotation instance.
    @annotation = Annotation.includes(
      { :field_group => [
          { :fields => [:translations, :field_options] },
          :translations
        ] },

      :data_entries
    ).references(
      { :field_group => [
          { :fields => [:translations, :field_options] },
          :translations
        ] },

      :data_entries
    ).find(params[:id])

    respond_to do |format|
      format.html # show.html.slim
      format.json { render json: @annotation }
    end
  end

  # GET /annotations/new
  # GET /annotations/new.json
  def new
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "new.html.slim" (project_root/annotations/new) and is used to populate the page with information about the annotation instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new annotation instance.
    @annotation = Annotation.new
    respond_to do |format|
      format.html # new.html.slim
      format.json { render json: @annotation }
    end
  end

  # GET /annotations/annotation_id/edit
  def edit
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "edit.html.slim" (project_root/annotations/edit) and is used to populate the page with information about the annotation instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent annotation instance.
    @annotation = Annotation
                    .includes(
                        {
                          field_group: [
                            {
                              fields: [:translations, :field_options]
                            },
                            :translations
                          ]
                        },
                        :data_entries
                      )
                      .find(params[:id])

    respond_to do |format|
      format.html # new.html.slim
      format.json# { render json: @annotation }
    end
  end

  # POST /annotations
  # POST /annotations.json
  def create
    Annotation.transaction do
      #@annotation is a variable containing an instance of the "annotation.rb" model created with data passed in the params of the "new.html.slim" form submit action.
      metadata = params.require(:annotation).permit!
      meta = metadata[:meta]
      data = metadata[:data].to_unsafe_h

      logger.debug "meta: " + meta.to_s
      logger.debug "data: " + data.to_s

      @annotation = Annotation.create!(
        transcription_id: meta[:transcription_id],
        page_id: meta[:page_id],
        field_group_id: meta[:field_group_id],
        x_tl: meta[:x_tl],
        y_tl: meta[:y_tl],
        width: meta[:width],
        height: meta[:height],
        date_time_id: annotation_params[:observation_date],
        observation_date: DateTime.parse(annotation_params[:observation_date])
      )

      process_annotation_data(annotation: @annotation, data: data)
    end
    respond_to do |format|
      format.json
    end
  rescue => e
    NewRelic::Agent.notice_error(e)
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n\t") if Rails.env.development?

    render status: :bad_request, text: e.message
  end

  # PUT /annotations/annotation_id
  # PUT /annotations/annotation_id.json
  def update
    Annotation.transaction do
      @annotation = Annotation.includes(:data_entries, :transcription).references(:data_entries).find(params[:id])
      metadata = params.require(:annotation).permit!
      meta = metadata[:meta]
      data = metadata[:data].to_unsafe_h if metadata[:data]

      if meta && data
        @annotation.update(
          x_tl: meta[:x_tl],
          y_tl: meta[:y_tl],
          width: meta[:width],
          height: meta[:height],
          date_time_id: annotation_params[:observation_date],
          observation_date: DateTime.parse(annotation_params[:observation_date])
        )

        process_annotation_data(annotation: @annotation, data: data)
      else
        # Rails.logger.info "Updating with backbone attributes"
        @annotation.update(backbone_annotation_params.merge(observation_date: DateTime.parse(annotation_params[:observation_date])))
      end

      # TODO: double save ?????
      @annotation.save!
    end

    respond_to do |format|
      format.json
    end
  rescue => e
    NewRelic::Agent.notice_error(e)
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n\t") if Rails.env.development?

    render status: :bad_request, text: e.message
  end

  # DELETE /annotations/annotation_id
  # DELETE /annotations/annotation_id.json
  def destroy
    #this function is called to delete the instance of "annotation.rb" identified by the annotation_id passed to the destroy function when it was called
    annotation = Annotation.find(params[:id])
    annotation.destroy

    respond_to do |format|
      format.html { redirect_to annotations_url }
      format.json { head :no_content }
    end
  end

  private

  def value_for_option_ids(ids)
    value = ""
    if ids.is_a?(String)
      ids = ids.split(',')
    end
    options = FieldOption.where(id: ids)
    value = options.map{|option| option.value}.join(" ") if options.any?

    value
  end

  def process_annotation_data(annotation:, data:)
    return unless data && data.length > 0
    data.each do |key, value|
      entry_value = value[:value]

      if value[:selected_option_ids].present?
        entry_value = value_for_option_ids value[:selected_option_ids]
      end

      datum = annotation.data_entries.find_or_create_by(
        page_id: value[:page_id],
        field_id: value[:field_id],
        data_type: value[:data_type]
      )
      datum.value = entry_value
      datum.user_id = value[:user_id] if datum.user_id.nil?
      datum.field_options_ids = (value[:selected_option_ids].present? ? value[:selected_option_ids] : nil)
      datum.save!
    end
  end

  def annotation_params
    params.require(:annotation).permit(:observation_date)
  end

  def backbone_annotation_params
    params.require(:annotation).permit(:x_tl, :y_tl, :width, :height, :page_id, :transcription_id, :date_time_id, :field_group_id, :observation_date)
  end
end
