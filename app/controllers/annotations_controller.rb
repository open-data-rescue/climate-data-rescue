class AnnotationsController < ApplicationController
  #load_and_authorize_resource
  respond_to :json
  
  #Corresponds to the "Annotation" model, Annotation.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the Annotation model
  # All .html.slim views for "annotation.rb" are located at "project_root\app\views\annotations"
  # GET /annotations
  # GET /annotations.json
  def index
    #@annotations is the variable containing all instances of the "annotation.rb" model passed to the annotation view "index.html.slim" (project_root/annotations) and is used to populate the page with information about each annotation using @annotations.each (an iterative loop).
    if params[:transcription_id]
      @annotations = Transcription.find(params[:transcription_id]).annotations
    else
      @annotations = Annotation.all
    end

    respond_to do |format|
      format.html # index.html.slim
      format.json 
    end
  end

  # GET /annotations/annotation_id
  # GET /annotations/annotation_id.json
  def show
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "show.html.slim" (project_root/annotations/annotation_id) and is used to populate the page with information about the annotation instance.
    @annotation = Annotation.find(params[:id])

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
    @annotation = Annotation.find(params[:id])
    respond_to do |format|
      format.html # new.html.slim
      format.json# { render json: @annotation }
    end
  end

  # POST /annotations
  # POST /annotations.json
  def create
    error = ""
    Annotation.transaction do
      begin
        #@annotation is a variable containing an instance of the "annotation.rb" model created with data passed in the params of the "new.html.slim" form submit action. 
        
        meta = params[:annotation][:meta]
        data = params[:annotation][:data]
        
        logger.debug "meta: " + meta.to_s
        logger.debug "data: " + data.to_s
        
        @annotation = Annotation.new(transcription_id: meta[:transcription_id], page_id: meta[:page_id], field_group_id: meta[:field_group_id], x_tl: meta[:x_tl], y_tl: meta[:y_tl], width: meta[:width], height: meta[:height])
        @annotation.date_time_id = annotation_params[:observation_date]
        @annotation.observation_date = DateTime.parse(annotation_params[:observation_date])

        if data && data.length > 0
          data.each do |key, value|
            entry_value = value[:value]

            if entry_value.class == Array
              entry_value = value_for_option_ids entry_value
            end


            @annotation.data_entries.build(page_id: value[:page_id], user_id: value[:user_id], field_id: value[:field_id], data_type: value[:data_type], value: entry_value, field_options_ids: (value[:selected_option_ids].present? ? value[:selected_option_ids] : nil))
          end
        end
        @annotation.save!

        respond_to do |format|
          format.json# { render json: @annotation }
        end
      rescue => e
        error = e.message
        Rails.logger.error error
        Rails.logger.error e.backtrace

        render json: {status: :bad_request, text: error}
      end
    end
    
    
  end

  # PUT /annotations/annotation_id
  # PUT /annotations/annotation_id.json
  def update
    #@annotation is a variable containing an instance of the "annotation.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    error = ""
    Annotation.transaction do
      begin

        @annotation = Annotation.find(params[:id])
        meta = params[:annotation][:meta]
        data = params[:annotation][:data]
        
        if meta && data
          @annotation.update(x_tl: meta[:x_tl], y_tl: meta[:y_tl], width: meta[:width], height: meta[:height])
          
          @annotation.date_time_id = annotation_params[:observation_date]
          @annotation.observation_date = DateTime.parse(annotation_params[:observation_date])
          
          if data && data.length > 0
            data.each do |key, value|
              entry_value = value[:value]

              if entry_value.class == Array
                entry_value = value_for_option_ids entry_value
              end

              datum = @annotation.data_entries.find_or_create_by(page_id: value[:page_id], user_id: value[:user_id], field_id: value[:field_id], data_type: value[:data_type])
              datum.value = entry_value
              datum.field_options_ids = (value[:selected_option_ids].present? ? value[:selected_option_ids] : nil)
              datum.save!
            end
          end
        else
          @annotation.update(backbone_annotation_params)
        end

        @annotation.save!
      rescue => e 
        error = e.message
        Rails.logger.error error
        Rails.logger.error e.backtrace
      end
    end


    respond_to do |format|
      format.json
    end
  end

  # DELETE /annotations/annotation_id
  # DELETE /annotations/annotation_id.json
  def destroy
    #this function is called to delete the instance of "annotation.rb" identified by the annotation_id passed to the destroy function when it was called
    @annotation = Annotation.find(params[:id])
    @annotation.destroy

    respond_to do |format|
      format.html { redirect_to annotations_url }
      format.json { head :no_content }
    end
  end
  
  private
  def value_for_option_ids ids
    value = ""
    value = ids.collect{|id| FieldOption.find(id).value}.join(" ") if ids.any?

    value
  end

  def annotation_params
    params.require(:annotation).permit(:observation_date)
  end
  def backbone_annotation_params
    params.require(:annotation).permit(:x_tl, :y_tl, :width, :height, :page_id, :transcription_id, :date_time_id, :field_group_id, :observation_date)
  end
end
