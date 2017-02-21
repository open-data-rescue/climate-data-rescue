class TranscriptionsController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  layout 'layouts/transcriber', :only => [:edit]
  #Corresponds to the "transcription" model, transcription.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the transcription model
  #All .html.slim views for "transcription.rb" are located at "project_root\app\views\transcriptions"
  
  before_action :ensure_login

  def my_transcriptions
    if current_user
      begin
        user = current_user
        @transcriptions = user.transcriptions
        render "index"
      rescue => e
        flash[:danger] = e.message
        redirect_to root_path
      end
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
      # @page = @transcription.page
    
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @transcription }
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
      @transcription = Transcription.find(params[:id])
      @page = @transcription.page
      @user = current_user
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
          @transcription.page.transcriber_id = transcription_params[:user_id]
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
    flash[:success] = I18n.t('transcription-saved-msg')
    respond_to do |format|
      format.html { redirect_to user_path(transcription.user)}
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
