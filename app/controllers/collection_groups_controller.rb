class CollectionGroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "collection_group" model, collection_group.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the collection_group model
  # All .html.slim views for "collection_group.rb" are located at "project_root\app\views\collection_groups"
  # GET /collection_groups
  # GET /collection_groups.json
  def index
    #@collection_groups is the variable containing all instances of the "collection_group.rb" model passed to the collection_group view "index.html.slim" (project_root/collection_groups) and is used to populate the page with information about each collection_group using @collection_groups.each (an iterative loop).
    @collection_groups = CollectionGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collection_groups }
    end
  end

  # GET /collection_groups/collection_group_id
  # GET /collection_groups/collection_group_id.json
  def show
    #@collection_group is a variable containing an instance of the "collection_group.rb" model. It is passed to the collection_group view "show.html.slim" (project_root/collection_groups/collection_group_id) and is used to populate the page with information about the collection_group instance.
    @collection_group = CollectionGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collection_group }
    end
  end

  # GET /collection_groups/new
  # GET /collection_groups/new.json
  def new
    #@collection_group is a variable containing an instance of the "collection_group.rb" model. It is passed to the collection_group view "new.html.slim" (project_root/collection_groups/new) and is used to populate the page with information about the collection_group instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new collection_group instance.
    @collection_group = CollectionGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @collection_group }
    end
  end

  # GET /collection_groups/collection_group_id/edit
  def edit
    #@collection_group is a variable containing an instance of the "collection_group.rb" model. It is passed to the collection_group view "edit.html.slim" (project_root/collection_groups/edit) and is used to populate the page with information about the collection_group instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent collection_group instance.
    @collection_group = CollectionGroup.find(params[:id])
  end

  # POST /collection_groups
  # POST /collection_groups.json
  def create
    #@collection_group is a variable containing an instance of the "collection_group.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @collection_group = CollectionGroup.new(params[:collection_group])

    respond_to do |format|
      if @collection_group.save
        format.html { redirect_to @collection_group, notice: 'Asset collection was successfully created.' }
        format.json { render json: @collection_group, status: :created, location: @collection_group }
      else
        format.html { render action: "new" }
        format.json { render json: @collection_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /collection_groups/collection_group_id
  # PUT /collection_groups/collection_group_id.json
  def update
    #@collection_group is a variable containing an instance of the "collection_group.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    @collection_group = CollectionGroup.find(params[:id])

    @collection_group.author = current_user.email
    respond_with @collection_group if @collection_group.save
    
  end

  # DELETE /collection_groups/collection_group_id
  # DELETE /collection_groups/collection_group_id.json
  def destroy
    #this function is called to delete the instance of "collection_group.rb" identified by the collection_group_id passed to the destroy function when it was called
    @collection_group = CollectionGroup.find(params[:id])
    @collection_group.destroy

    respond_to do |format|
      format.html { redirect_to collection_groups_url }
      format.json { head :no_content }
    end
  end
end