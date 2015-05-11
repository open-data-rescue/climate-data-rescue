class AssetCollectionsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "asset_collection" model, asset_collection.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the asset_collection model
  # All .html.slim views for "asset_collection.rb" are located at "project_root\app\views\asset_collections"

  # GET /asset_collections
  # GET /asset_collections.json
  def index
    #@asset_collections is the variable containing all instances of the "asset_collection.rb" model passed to the asset_collection view "index.html.slim" (project_root/asset_collections) and is used to populate the page with information about each asset_collection using @asset_collections.each (an iterative loop).
    @asset_collections = AssetCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_collections }
    end
  end

  # GET /asset_collections/asset_collection_id
  # GET /asset_collections/asset_collection_id.json
  def show
    #@asset_collection is a variable containing an instance of the "asset_collection.rb" model. It is passed to the asset_collection view "show.html.slim" (project_root/asset_collections/asset_collection_id) and is used to populate the page with information about the asset_collection instance.
    @asset_collection = AssetCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset_collection }
    end
  end

  # GET /asset_collections/new
  # GET /asset_collections/new.json
  def new
    #@asset_collection is a variable containing an instance of the "asset_collection.rb" model. It is passed to the asset_collection view "new.html.slim" (project_root/asset_collections/new) and is used to populate the page with information about the asset_collection instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new asset_collection instance.
    @asset_collection = AssetCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_collection }
    end
  end

  # GET /asset_collections/asset_collection_id/edit
  def edit
    #@asset_collection is a variable containing an instance of the "asset_collection.rb" model. It is passed to the asset_collection view "edit.html.slim" (project_root/asset_collections/edit) and is used to populate the page with information about the asset_collection instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent asset_collection instance.
    @asset_collection = AssetCollection.find(params[:id])
  end

  # POST /asset_collections
  # POST /asset_collections.json
  def create
    #@asset_collection is a variable containing an instance of the "asset_collection.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @asset_collection = AssetCollection.new(params[:asset_collection])

    respond_to do |format|
      if @asset_collection.save
        format.html { redirect_to @asset_collection, notice: 'Asset collection was successfully created.' }
        format.json { render json: @asset_collection, status: :created, location: @asset_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_collections/asset_collection_id
  # PUT /asset_collections/asset_collection_id.json
  def update
    #@asset_collection is a variable containing an instance of the "asset_collection.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    @asset_collection = AssetCollection.find(params[:id])

    @asset_collection.author = current_user.email
    respond_with @asset_collection if @asset_collection.save
    
  end

  # DELETE /asset_collections/asset_collection_id
  # DELETE /asset_collections/asset_collection_id.json
  def destroy
    #this function is called to delete the instance of "asset_collection.rb" identified by the asset_collection_id passed to the destroy function when it was called
    @asset_collection = AssetCollection.find(params[:id])
    @asset_collection.destroy

    respond_to do |format|
      format.html { redirect_to asset_collections_url }
      format.json { head :no_content }
    end
  end
end
