class TranscriptionsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "transcription" model, transcription.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the transcription model
  #All .html.slim views for "transcription.rb" are located at "project_root\app\views\transcriptions"
  
  # GET /transcriptions
  # GET /transcriptions.json
  def index
    #@transcriptions is the variable containing all instances of the "transcription.rb" model passed to the transcription view "index.html.slim" (project_root/transcriptions) and is used to populate the page with information about each transcription using @transcriptions.each (an iterative loop).
    if current_user.admin?
      @transcriptions = Transcription.all
    else
      @transcriptions = current_user.transcriptions.all
    end
  end

  # GET /transcriptions/transcription_id
  # GET /transcriptions/transcription_id.json
  def show
    #@transcription is a variable containing an instance of the "transcription.rb" model. It is passed to the transcription view "show.html.slim" (project_root/transcriptions/transcription_id) and is used to populate the page with information about the transcription instance.
    @transcription = Transcription.find(params[:id])
   # @asset = @transcription.asset
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transcription }
    end
  end

  # GET /transcriptions/new
  # GET /transcriptions/new.json
  def new
    #@transcription is a variable containing an instance of the "transcription.rb" model. It is passed to the transcription view "new.html.slim" (project_root/transcriptions/new) and is used to populate the page with information about the transcription instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new transcription instance.
    @user = current_user
    get_or_assign_asset(params[:currentAsset])
    @entities = @asset.template.entities.all
    @transcription = Transcription.new
    
    
  end

  # GET /transcriptions/transcription_id/edit
  def edit
    #@transcription is a variable containing an instance of the "transcription.rb" model. It is passed to the transcription view "edit.html.slim" (project_root/transcriptions/edit) and is used to populate the page with information about the transcription instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent transcription instance.
    @transcription = Transcription.find(params[:id])
    @asset = @transcription.asset
    @user = current_user
  end

  # POST /transcriptions
  # POST /transcriptions.json
  def create
    #@transcription is a variable containing an instance of the "transcription.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @transcription = Transcription.new(params[:transcription])
    #on new transcription creation, this function is called on the transcription asset to update it's transcription count. Once it reaches 5, the asset is marked as "done"
    @transcription.asset.increment_classification_count
    #increments current user's contribution count with each new transcription created by them
    current_user.increment_contributions
    respond_to do |format|
      if @transcription.save
        format.html { redirect_to @transcription, notice: 'transcription was successfully created.' }
        format.json { render json: @transcription, status: :created, location: @transcription }
      else
        format.html { render action: "new" }
        format.json { render json: @transcription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transcriptions/transcription_id
  # PUT /transcriptions/transcription_id.json
  def update
    #@transcription is a variable containing an instance of the "transcription.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    transcription = Transcription.find(params[:id])

     logger.error "count not find transcription to update" unless transcription
     
     transcription_params = params[:transcription]
     
     transcription.transcriptions.delete_all
     transcription.add_transcriptions_from_json( transcription_params[:transcriptions])
     
     respond_to do |format|
       format.js { render :nothing => true, :status => :created }
     end
  end

  # DELETE /transcriptions/transcription_id
  # DELETE /transcriptions/transcription_id.json
  def destroy
    #this function is called to delete the instance of "transcription.rb" identified by the transcription_id passed to the destroy function when it was called
    if current_user.admin?
      @transcription = Transcription.find(params[:id])
      @transcription.destroy

      respond_to do |format|
        format.html { redirect_to transcriptions_url }
        format.json { head :no_content }
      end
    else
      redirect_to transcription_path(params[:id]), alert: 'Only administrators can delete transcriptions!'
    end
  end
  #this function gets a random asset for display on the new transcription page if one has not been set by selecting "Transcribe" on an asset's show page
  def get_or_assign_asset(currentAsset)
    if currentAsset.present?
      @asset = Asset.find(currentAsset)
    else
      @asset = Asset.transcribeable.order("RANDOM()").first
    end
  end
end
