class FieldgroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "fieldgroup" model, fieldgroup.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the fieldgroup model
  #Fieldgroups contain (relate to) many fields and group them based on their location on a page
  #All .html.slim views for "fieldgroup.rb" are located at "project_root\app\views\fieldgroups"
  # GET /fieldgroups
  # GET /fieldgroups.json
  def index
    
    if current_user && current_user.admin?
      #@fieldgroups is the variable containing all instances of the "fieldgroup.rb" model passed to the fieldgroup view "index.html.slim" (project_root/fieldgroups) and is used to populate the page with information about each fieldgroup using @fieldgroups.each (an iterative loop).
      @fieldgroups = Fieldgroup.all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fieldgroups }
      end
    else
      flash[:danger] = 'Only administrators can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /fieldgroups/fieldgroup_id
  # GET /fieldgroups/fieldgroup_id.json
  def show
    if current_user && current_user.admin?
      #@fieldgroup is a variable containing an instance of the "fieldgroup.rb" model. It is passed to the fieldgroup view "show.html.slim" (project_root/fieldgroups/fieldgroup_id) and is used to populate the page with information about the fieldgroup instance.
      @fieldgroup = Fieldgroup.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @fieldgroup }
      end
    else
      flash[:danger] = 'Only administrators can view fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /fieldgroups/new
  # GET /fieldgroups/new.json
  def new
    if current_user && current_user.admin?
      
      Fieldgroup.transaction do
        begin
          #@fieldgroup is a variable containing an instance of the "fieldgroup.rb" model. It is passed to the fieldgroup view "new.html.slim" (project_root/fieldgroups/new) and is used to populate the page with information about the fieldgroup instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new fieldgroup instance.
          @fieldgroup = Fieldgroup.new
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @fieldgroup }
      end
      
    else
      flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /fieldgroups/fieldgroup_id/edit
  def edit
    if current_user && current_user.admin?
      Fieldgroup.transaction do
        begin
          #@fieldgroup is a variable containing an instance of the "fieldgroup.rb" model. It is passed to the fieldgroup view "edit.html.slim" (project_root/fieldgroups/edit) and is used to populate the page with information about the fieldgroup instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent fieldgroup instance.
          @fieldgroup = Fieldgroup.find(params[:id])
        rescue => e
          # flash[:danger] = e.message
        end
      end
    else
      flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # POST /fieldgroups
  # POST /fieldgroups.json
  def create
    if current_user && current_user.admin?
      
      Fieldgroup.transaction do
        begin
          #@fieldgroup is a variable containing an instance of the "fieldgroup.rb" model created with data passed in the params of the "new.html.slim" form submit action.
          @fieldgroup = Fieldgroup.new(params[:fieldgroup])
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @fieldgroup.save
          format.html { redirect_to @fieldgroup, notice: 'Fieldgroup was successfully created.' }
          format.json { render json: @fieldgroup, status: :created, location: @fieldgroup }
        else
          format.html { render action: "new" }
          format.json { render json: @fieldgroup.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    else
      flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # PUT /fieldgroups/fieldgroup_id
  # PUT /fieldgroups/fieldgroup_id.json
  def update
    if current_user && current_user.admin?
      
      Fieldgroup.transaction do
        begin
          #@fieldgroup is a variable containing an instance of the "fieldgroup.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
          @fieldgroup = Fieldgroup.find(params[:id])
        rescue => e
          # flash[:danger] = e.message
        end
      end

      respond_to do |format|
        if @fieldgroup.update_attributes(params[:fieldgroup])
          format.html { redirect_to @fieldgroup, notice: 'Fieldgroup was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @fieldgroup.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    else
      flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # DELETE /fieldgroups/fieldgroup_id
  # DELETE /fieldgroups/fieldgroup_id.json
  def destroy
    if current_user && current_user.admin?
      
      Fieldgroup.transaction do
        begin
          #this function is called to delete the instance of "fieldgroup.rb" identified by the fieldgroup_id passed to the destroy function when it was called
          @fieldgroup = Fieldgroup.find(params[:id])
          @fieldgroup.destroy
        rescue => e
          # flash[:danger] = e.message
        end
      end

      respond_to do |format|
        format.html { redirect_to fieldgroups_url }
        format.json { head :no_content }
      end
    else
      flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end
end
