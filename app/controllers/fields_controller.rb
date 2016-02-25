class FieldsController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "field" model, field.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the field model
  #All .html.slim views for "field.rb" are located at "project_root\app\views\fields"
  # GET /fields
  # GET /fields.json
  def index
    #@fields is the variable containing all instances of the "field.rb" model passed to the field view "index.html.slim" (project_root/fields) and is used to populate the page with information about each field using @fields.each (an iterative loop).
    if current_user && current_user.admin?
      @fields = Field.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fields }
      end
    else
      flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /fields/field_id
  # GET /fields/field_id.json
  def show
    #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "show.html.slim" (project_root/fields/field_id) and is used to populate the page with information about the field instance.
    if current_user && current_user.admin?
      @field = Field.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @field }
      end
      
    else
      flash[:danger] = 'Only administrators can view fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /fields/new
  # GET /fields/new.json
  def new
    if current_user && current_user.admin?
      Field.transaction do
        begin
          #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "new.html.slim" (project_root/fields/new) and is used to populate the page with information about the field instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new field instance.
          @field = Field.new
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @pagetype }
      end
      
    else
      flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /fields/field_id/edit
  def edit
    if current_user && current_user.admin?
      Field.transaction do
        begin
          #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "edit.html.slim" (project_root/fields/edit) and is used to populate the page with information about the field instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent field instance.
          @field = Field.find(params[:id])
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
    else
      flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # POST /fields
  # POST /fields.json
  def create
    if current_user && current_user.admin?
        
      Field.transaction do
        begin
          #@field is a variable containing an instance of the "field.rb" model created with data passed in the params of the "new.html.slim" form submit action.
          @field = Field.new(field_params)
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @field.save
          format.html { redirect_to @field, notice: 'Field was successfully created.' }
          format.json { render json: @field, status: :created, location: @field }
        else
          format.html { render action: "new" }
          format.json { render json: @field.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    else
      flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # PUT /fields/field_id
  # PUT /fields/field_id.json
  def update
    if current_user && current_user.admin?
      
      Field.transaction do
        begin
          #@field is a variable containing an instance of the "field.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
          @field = Field.find(params[:id])
        rescue => e
          # flash[:danger] = e.message
        end
      end

      respond_to do |format|
        if @field.update_attributes(field_params)
          format.html { redirect_to @field, notice: 'Field was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @field.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    else
      flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # DELETE /fields/field_id
  # DELETE /fields/field_id.json
  def destroy
    #this function is called to delete the instance of "field.rb" identified by the field_id passed to the destroy function when it was called
    if current_user && current_user.admin?
      Field.transaction do
        begin
          @field = Field.find(params[:id])
          @field.destroy
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        format.html { redirect_to fields_url }
        format.json { head :no_content }
      end
      
    else
      flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end
  
  private
  def field_params
    params.require(:field).permit(:field_key, :initial_value, :kind, :name, :options, :validations)
  end
end
