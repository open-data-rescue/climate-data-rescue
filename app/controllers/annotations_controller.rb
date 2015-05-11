class AnnotationsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  
  #Corresponds to the "Annotation" model, Annotation.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the Annotation model
  # All .html.slim views for "annotation.rb" are located at "project_root\app\views\annotations"
  # GET /annotations
  # GET /annotations.json
  def index
    #@annotations is the variable containing all instances of the "annotation.rb" model passed to the annotation view "index.html.slim" (project_root/annotations) and is used to populate the page with information about each annotation using @annotations.each (an iterative loop).
    @annotations = Annotation.all

    respond_to do |format|
      format.html # index.html.slim
      format.json { render json: @annotations }
    end
  end

  # GET /annotations/annotation_id
  # GET /annotations/annotation_id.json
  def show
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "show.html.slim" (project_root/annotations/annotation_id) and is used to populate the page with information about the annotation instance.
    @annotation = Annotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.slim
      format.json { render json: @annotation }
    end
  end

  # GET /annotations/new
  # GET /annotations/new.json
  def new
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "new.html.slim" (project_root/annotations/new) and is used to populate the page with information about the annotation instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new annotation instance.
    @annotation = Annotation.new
    respond_to do |format|
      format.html # new.html.slim
      format.json { render json: @annotation }
    end
  end

  # GET /annotations/annotation_id/edit
  def edit
    #@annotation is a variable containing an instance of the "annotation.rb" model. It is passed to the annotation view "edit.html.slim" (project_root/annotations/edit) and is used to populate the page with information about the annotation instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent annotation instance.
    @annotation = Annotation.find(params[:id])
  end

  # POST /annotations
  # POST /annotations.json
  def create
    #@annotation is a variable containing an instance of the "annotation.rb" model created with data passed in the params of the "new.html.slim" form submit action. 
    @annotation = Annotation.new(params[:annotation])
    
    respond_to do |format|
      if @annotation.save
        flash[:notice] = 'success'
        format.html { redirect_to @annotation, notice: 'Annotation was successfully created.' }
        format.json { render json: @annotation, status: :created, location: @annotation }
      else
        format.html { render action: "new" }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /annotations/annotation_id
  # PUT /annotations/annotation_id.json
  def update
    #@annotation is a variable containing an instance of the "annotation.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    @annotation = Annotation.find(params[:id])

    respond_to do |format|
      if @annotation.update_attributes(params[:annotation])
        format.html { redirect_to @annotation, notice: 'Annotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotations/annotation_id
  # DELETE /annotations/annotation_id.json
  def destroy
    #this function is called to delete the instance of "annotation.rb" identified by the annotation_id passed to the destroy function when it was called
    @annotation = Annotation.find(params[:id])
    @annotation.destroy

    respond_to do |format|
      format.html { redirect_to annotations_url }
      format.json { head :no_content }
    end
  end
end
