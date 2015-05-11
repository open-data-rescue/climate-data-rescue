class EntitiesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "entity" model, entity.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the entity model
  #Entities are known as Field Groups in the user interface, and contain (relate to) many fields
  #All .html.slim views for "entity.rb" are located at "project_root\app\views\entities"
  # GET /entities
  # GET /entities.json
  def index
    #@entities is the variable containing all instances of the "entity.rb" model passed to the entity view "index.html.slim" (project_root/entities) and is used to populate the page with information about each entity using @entities.each (an iterative loop).
    @entities = Entity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entities }
    end
  end

  # GET /entities/entity_id
  # GET /entities/entity_id.json
  def show
    #@entity is a variable containing an instance of the "entity.rb" model. It is passed to the entity view "show.html.slim" (project_root/entities/entity_id) and is used to populate the page with information about the entity instance.
    @entity = Entity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entities/new
  # GET /entities/new.json
  def new
    #@entity is a variable containing an instance of the "entity.rb" model. It is passed to the entity view "new.html.slim" (project_root/entities/new) and is used to populate the page with information about the entity instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new entity instance.
    @entity = Entity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entities/entity_id/edit
  def edit
    #@entity is a variable containing an instance of the "entity.rb" model. It is passed to the entity view "edit.html.slim" (project_root/entities/edit) and is used to populate the page with information about the entity instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent entity instance.
    @entity = Entity.find(params[:id])
    
  end

  # POST /entities
  # POST /entities.json
  def create
    #@entity is a variable containing an instance of the "entity.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @entity = Entity.new(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to @entity, notice: 'Entity was successfully created.' }
        format.json { render json: @entity, status: :created, location: @entity }
      else
        format.html { render action: "new" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entities/entity_id
  # PUT /entities/entity_id.json
  def update
    #@entity is a variable containing an instance of the "entity.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    @entity = Entity.find(params[:id])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to @entity, notice: 'Entity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/entity_id
  # DELETE /entities/entity_id.json
  def destroy
    #this function is called to delete the instance of "entity.rb" identified by the entity_id passed to the destroy function when it was called
    @entity = Entity.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url }
      format.json { head :no_content }
    end
  end
end
