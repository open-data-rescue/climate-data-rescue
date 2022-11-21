module Admin
  class TranscriptionsController < AdminController
    #load_and_authorize_resource
    #Corresponds to the "transcription" model, transcription.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the transcription model
    #All .html.slim views for "transcription.rb" are located at "project_root\app\views\transcriptions"

    # GET /transcriptions
    # GET /transcriptions.json
    def index
      @transcriptions = transcriptions
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
        @exporter = TranscriptionExporter.new(
          page_type_id: params['page_type_id']
        )
      end

      respond_to do |format|
        format.html
        format.csv { send_data @exporter.export, filename: @exporter.filename }
        format.json { render json: @exporter.export(format: :json), filename: @exporter.filename(format: :json), type: :json, disposition: "attachment" }
      end
    end

    private

    def transcriptions
      transcriptions_filter = nil
      transcriptions_joins = nil
      if params[:review_transcriptions]
        transcriptions_filter = {
          complete: true,
          pages: {
            done: false
          }
        }
        transcriptions_joins = :page
      end

      Transcription.includes(:user, :page, :page_type)
                   .where(transcriptions_filter)
                   .joins(transcriptions_joins)
                   .references(transcriptions_joins)
                   .order(updated_at: :desc)
    end

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
