class FieldsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "field" model, field.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the field model
  #All .html.slim views for "field.rb" are located at "project_root\app\views\fields"
  # GET /fields
  # GET /fields.json
  def index
    #@fields is the variable containing all instances of the "field.rb" model passed to the field view "index.html.slim" (project_root/fields) and is used to populate the page with information about each field using @fields.each (an iterative loop).
    if current_user.admin?
      @fields = Field.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fields }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end

  # GET /fields/field_id
  # GET /fields/field_id.json
  def show
    #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "show.html.slim" (project_root/fields/field_id) and is used to populate the page with information about the field instance.
    if current_user.admin?
      @field = Field.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @field }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end

  # GET /fields/new
  # GET /fields/new.json
  def new
    #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "new.html.slim" (project_root/fields/new) and is used to populate the page with information about the field instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new field instance.
    if current_user.admin?
      @field = Field.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @asset_collection }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end

  # GET /fields/field_id/edit
  def edit
    #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "edit.html.slim" (project_root/fields/edit) and is used to populate the page with information about the field instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent field instance.
    if current_user.admin?
      @field = Field.find(params[:id])
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end

  # POST /fields
  # POST /fields.json
  def create
    #@field is a variable containing an instance of the "field.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    if current_user.admin?
      @field = Field.new(params[:field])

      respond_to do |format|
        if @field.save
          format.html { redirect_to @field, notice: 'Field was successfully created.' }
          format.json { render json: @field, status: :created, location: @field }
        else
          format.html { render action: "new" }
          format.json { render json: @field.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end

  # PUT /fields/field_id
  # PUT /fields/field_id.json
  def update
    #@field is a variable containing an instance of the "field.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    if current_user.admin?
      @field = Field.find(params[:id])

      respond_to do |format|
        if @field.update_attributes(params[:field])
          format.html { redirect_to @field, notice: 'Field was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @field.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end

  # DELETE /fields/field_id
  # DELETE /fields/field_id.json
  def destroy
    #this function is called to delete the instance of "field.rb" identified by the field_id passed to the destroy function when it was called
    if current_user.admin?
      @field = Field.find(params[:id])
      @field.destroy

      respond_to do |format|
        format.html { redirect_to fields_url }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify fields!'
    end
  end
end
