class AssetsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "asset" model, asset.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the asset model
  #All .html.slim views for "asset.rb" are located at "project_root\app\views\assets"
  # GET /assets
  # GET /assets.json
  def index
    #@assets is the variable containing all instances of the "asset.rb" model passed to the asset view "index.html.slim" (project_root/assets) and is used to populate the page with information about each asset using @assets.each (an iterative loop).
    if current_user.admin?
      @assets = Asset.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @assets }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify assets!'
    end
  end

  # GET /assets/asset_id
  # GET /assets/asset_id.json
  def show
    #@asset is a variable containing an instance of the "asset.rb" model. It is passed to the asset view "show.html.slim" (project_root/assets/asset_id) and is used to populate the page with information about the asset instance.
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    #@asset is a variable containing an instance of the "asset.rb" model. It is passed to the asset view "new.html.slim" (project_root/assets/new) and is used to populate the page with information about the asset instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new asset instance.
    if current_user.admin?
      @asset = Asset.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @asset }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify assets!'
    end
  end

  # GET /assets/asset_id/edit
  def edit
    #@asset is a variable containing an instance of the "asset.rb" model. It is passed to the asset view "edit.html.slim" (project_root/assets/edit) and is used to populate the page with information about the asset instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent asset instance.
    if current_user.admin?
      @asset = Asset.find(params[:id])
    else
      redirect_to root_path, alert: 'Only administrators can modify assets!'
    end
  end

  # POST /assets
  # POST /assets.json
  def create
    #@asset is a variable containing an instance of the "asset.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @asset = Asset.new(params[:asset])
    @asset.extract_upload_dimensions
    #respond_with(@asset, location: asset_path(@asset)) if @asset.save
    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/asset_id
  # PUT /assets/asset_id.json
  def update
    #@asset is a variable containing an instance of the "asset.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action.
    @asset = Asset.find(params[:id])
    if @asset.width==nil
      @asset.extract_dimensions
    end
    @asset.set_name_to_filename
    
    #respond_with @asset if @asset.save
    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/asset_id
  # DELETE /assets/asset_id.json
  def destroy
    #this function is called to delete the instance of "asset.rb" identified by the asset_id passed to the destroy function when it was called
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
