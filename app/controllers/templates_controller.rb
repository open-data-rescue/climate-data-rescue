class TemplatesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "template" model, template.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the template model
  #All .html.slim views for "template.rb" are located at "project_root\app\views\templates"
  # GET /templates
  # GET /templates.json
  def index
    #@templates is the variable containing all instances of the "template.rb" model passed to the template view "index.html.slim" (project_root/templates) and is used to populate the page with information about each template using @templates.each (an iterative loop).
    if current_user.admin?
      @templates = Template.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @templates }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end

  # GET /templates/template_id
  # GET /templates/template_id.json
  def show
    #@template is a variable containing an instance of the "template.rb" model. It is passed to the template view "show.html.slim" (project_root/templates/template_id) and is used to populate the page with information about the template instance.
    if current_user.admin?  
      @template = Template.find(params[:id])
      @assets = Asset.all
      respond_to do |format|
        format.html
        format.json {
          render :json => @asset.template.to_json(:include => { :fieldgroups => { :include => :fields }})
        }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end

  # GET /templates/new
  # GET /templates/new.json
  def new
    #@template is a variable containing an instance of the "template.rb" model. It is passed to the template view "new.html.slim" (project_root/templates/new) and is used to populate the page with information about the template instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new template instance.
    if current_user.admin?
      @template = Template.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @template }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end

  # GET /templates/template_id/edit
  def edit
    #@template is a variable containing an instance of the "template.rb" model. It is passed to the template view "edit.html.slim" (project_root/templates/edit) and is used to populate the page with information about the template instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent template instance.
    if current_user.admin?
      @template = Template.find(params[:id])
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end

  # POST /templates
  # POST /templates.json
  def create
    #@template is a variable containing an instance of the "template.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    if current_user.admin?
      @template = Template.new(params[:template])

      respond_to do |format|
        if @template.save
          format.html { redirect_to @template, notice: 'Template was successfully created.' }
          format.json { render json: @template, status: :created, location: @template }
        else
          format.html { render action: "new" }
          format.json { render json: @template.errors, status: :unprocessable_fieldgroup }
        end
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end

  # PUT /templates/template_id
  # PUT /templates/template_id.json
  def update
    #@template is a variable containing an instance of the "template.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    if current_user.admin?
      @template = Template.find(params[:id])

      respond_to do |format|
        if @template.update_attributes(params[:template])
          format.html { redirect_to @template, notice: 'Template was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @template.errors, status: :unprocessable_fieldgroup }
        end
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end

  # DELETE /templates/template_id
  # DELETE /templates/template_id.json
  def destroy
    #this function is called to delete the instance of "template.rb" identified by the template_id passed to the destroy function when it was called
    if current_user.admin?
      @template = Template.find(params[:id])
      @template.destroy

      respond_to do |format|
        format.html { redirect_to templates_url }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify templates!'
    end
  end
end
