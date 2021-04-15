module Admin
  class TranscriptionsController < AdminController
    #load_and_authorize_resource
    #Corresponds to the "transcription" model, transcription.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the transcription model
    #All .html.slim views for "transcription.rb" are located at "project_root\app\views\transcriptions"

    # GET /transcriptions
    # GET /transcriptions.json
    def index
      @transcriptions = Transcription.order(updated_at: :desc)
    end

    # GET /transcriptions/transcription_id
    # GET /transcriptions/transcription_id.json
    def show
      @transcription = Transcription.find(params[:id])
    
      respond_to do |format|
        format.html # show.html.erb
        # format.json { render json: @transcription }
      end
    end

    # GET /transcriptions/transcription_id/edit
    def edit
      @transcription = Transcription.find(params[:id])
    end

    # PUT /transcriptions/transcription_id
    # PUT /transcriptions/transcription_id.json
    def update
      Transcription.transaction do
        begin
          transcription = Transcription.find(params[:id])

          transcription.update(transcription_params)
          flash[:success] = I18n.t('transcription-sucessfully-updated')
        rescue => e
          flash[:danger] = e.message
        end
      end

      respond_to do |format|
        format.html { redirect_to admin_transcriptions_path}
      end
    end

    # DELETE /transcriptions/transcription_id
    # DELETE /transcriptions/transcription_id.json
    def destroy
      Transcription.transaction do
        begin
          @transcription = Transcription.find(params[:id])
          @transcription.destroy
        rescue => e
          flash[:danger] = e.message
        end
      end

      respond_to do |format|
        format.html { redirect_to admin_transcriptions_path }
        format.json { head :no_content }
      end
    end

    def export
      Rails.logger.info params
      if request.format.html?
        @page_types = PageType.order(:title).distinct
      else
        limit = params['limit'] || nil
        offset = params['offset'] || nil

        if params['page_type_id'].present?
          @page_type = PageType.includes(
            { 
              page_types_field_groups: { 
                field_group: {
                  field_groups_fields: :field
                }
              }
            }
          )
          .find(params['page_type_id'])

          if @page_type.present?
            # @data_entries = DataEntry.joins(:annotation, :field).where(
            #   field_id: @page_type.fields.pluck(:id),
            #   annotation_id: @page_type.annotations.pluck(:id)
            # )
            @transcriptions = @page_type.transcriptions
                                        .select(Arel.star, Page.arel_table[:start_date])
                                        .joins(
                                          :annotations,
                                          :page
                                        )
                                        .preload(:data_entries)
                                        .order('pages.start_date ASC')
                                        .limit(limit).offset(offset)
                                        .distinct
          end
        else
          @transcriptions = Transcription.joins(
            :data_entries,
            :page
          ).limit(limit).offset(offset).order('pages.start_date ASC').distinct
        end
      end

      respond_to do |format|
        format.html
        format.csv do
          require 'csv'
          response.headers['Content-Disposition'] =
            "attachment; \
            filename=DRAW_transcriptions_#{DateTime.current}.csv"
          # response.headers['Content-Type'] = 'text/plain'
        end
        format.json
        # format.xlsx do
        #   response.headers['Content-Disposition'] =
        #     "attachment; \
        #     filename='DRAW_transcriptions_#{Datetime.current}.xlsx'"
        # end
      end
    end

    private

    def get_or_assign_page(page_id)
    # this function gets a random page for display on the new transcription page 
    # if one has not been set by selecting "Transcribe" on an page's show page
      if page_id
        page = Page.find(page_id)
      else
        page = Page.transcribeable.unseen(current_user).reorder("RAND()").first
      end
      
      page
    end

    def transcription_params
      params.require(:transcription).permit(:user_id, :page_id, :complete)
    end
  end
end
