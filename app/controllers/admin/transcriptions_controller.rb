module Admin
  class TranscriptionsController < AdminController
    #load_and_authorize_resource
    #Corresponds to the "transcription" model, transcription.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the transcription model
    #All .html.slim views for "transcription.rb" are located at "project_root\app\views\transcriptions"

    # GET /transcriptions
    # GET /transcriptions.json
    def index
      @transcriptions = Transcription.all
    end

    # GET /transcriptions/transcription_id
    # GET /transcriptions/transcription_id.json
    def show
      # @transcription is a variable containing an instance of the "transcription.rb" model. 
      # It is passed to the transcription view "show.html.slim" (project_root/transcriptions/transcription_id)
      # and is used to populate the page with information about the transcription instance.
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
          # @transcription is a variable containing an instance of the "transcription.rb" model 
          # with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
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
    
    
    
    private

    def get_or_assign_page(page_id) #TODO: shouldn't this be in the helper - file not the controller?
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
