class TranscriptionsController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  before_action :ensure_current_user
  layout 'layouts/transcriber', :only => [:edit]
  layout 'raw', :only => [:completed_transcriptions_table]
  #Corresponds to the "transcription" model, transcription.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the transcription model
  #All .html.slim views for "transcription.rb" are located at "project_root\app\views\transcriptions"

  def index
    redirect_to my_profile_path
  end

  def completed_transcriptions_table
    if params[:id] #user ID
      @user = User.includes(
        {
          transcriptions: [
            { 
              page: [
                :page_days
              ] 
            },
            :annotations
          ]
        },
        :data_entries
      ).find(params[:id])

      @completed_transcriptions =
        @user.transcriptions
             .completed
             .order(updated_at: :desc)
             .includes([
               { 
                 page: [
                   :page_days,
                   :page_type
                 ] 
               },
               { annotations: :data_entries },
               :user
             ])
             .references([
               { 
                 page: [
                   :page_days,
                   :page_type
                 ] 
               },
               { annotations: :data_entries },
               :user
             ])
    end
  end

  # GET /transcriptions/transcription_id
  # GET /transcriptions/transcription_id.json
  def show    
    if current_user
      # @transcription is a variable containing an instance of the "transcription.rb" model. 
      # It is passed to the transcription view "show.html.slim" (project_root/transcriptions/transcription_id)
      # and is used to populate the page with information about the transcription instance.
      @transcription = Transcription.find(params[:id])
      
      if params['only_data_table'].present? && params['only_data_table'] == true || params['only_data_table'] == 'true'
        render 'data_view', layout: 'raw'
      end
    else
      flash[:danger] = 'Only users can view transcriptions! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /transcriptions/new
  # GET /transcriptions/new.json
  def new
    if current_user
      # @transcription is a variable containing an instance of the "transcription.rb" model.
      # It is passed to the transcription view "new.html.slim" (project_root/transcriptions/new)
      # and is used to populate the page with information about the transcription instance.
      # "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to 
      # set the attributes of the new transcription instance.
      
      @page = get_or_assign_page(params[:current_page_id])
      
      if @page && current_user.transcriptions.any? && (current_user.transcriptions.collect(&:page_id).include? @page.id)
        redirect_to edit_transcription_path(current_user.transcriptions.find_by(:page_id => @page.id))
      end
      @user = current_user
      @field_groups = @page.page_type.field_groups if @page && @page.page_type
      @transcription = Transcription.new
      
    else
      flash[:danger] = 'Only users can transcribe pages. <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /transcriptions/transcription_id/edit
  def edit
    if current_user
      @transcription = Transcription.includes(:page).find(params[:id])
      @page = @transcription.page
      @field_groups = @page.field_groups.includes(
        { 
          fields: [
            :translations,
            :field_groups_fields,
            :field_options
          ]
        },
        :translations
      ).references(
        { 
          fields: [
            :field_groups_fields
          ]
        }
      )
      @user = current_user
      @content_pages = StaticPage.transcriber_links.includes(
        :translations,
        :children
      )
    else
      flash[:danger] = 'Only users can transcribe documents! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # POST /transcriptions
  # POST /transcriptions.json
  def create
    if current_user
      
      Transcription.transaction do
        begin
          # @transcription is a variable containing an instance of the "transcription.rb" model 
          # created with data passed in the params of the "new.html.slim" form submit action.
          @transcription = nil
          @transcription = Transcription.create!(transcription_params)
          @transcription.page.save!
        rescue => e
          flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @transcription && @transcription.id
          flash[:info] = 'You may now begin transcribing'
          format.html { redirect_to edit_transcription_url(@transcription) }
        else
          format.html { redirect_to transcribe_page_url(:current_page_id => params[:page_id]) }
        end
      end
      
    else
      flash[:danger] = 'Only users can create transcriptions! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # PUT /transcriptions/transcription_id
  # PUT /transcriptions/transcription_id.json
  def update
    transcription = Transcription.find(params[:id])
    transcription.update(transcription_params)
    flash[:success] = I18n.t('transcription-saved-msg')
    respond_to do |format|
      format.html { redirect_to transcription}
    end
  end
  
  
  
  private

  def get_or_assign_page(page_id) #TODO: shouldn't this be in the helper - file not the controller?
  # this function gets a random page for display on the new transcription page 
  # if one has not been set by selecting "Transcribe" on an page's show page
    if page_id
      page = Page.find(page_id)
    else
      page = Page.inactive.transcribeable.unseen(current_user).reorder("RAND()").first
    end
    
    page
  end

  def transcription_params
    params.require(:transcription).permit(:user_id, :page_id, :complete)
  end
end
