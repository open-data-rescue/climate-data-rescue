class AnnotationsController < ApplicationController
  #load_and_authorize_resource
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
    error = ""
    Annotation.transaction do
      begin
        #@annotation is a variable containing an instance of the "annotation.rb" model created with data passed in the params of the "new.html.slim" form submit action. 
        
        meta = params[:annotation][:meta]
        data = params[:annotation][:data]
        
        logger.debug "meta: " + meta.to_s
        logger.debug "data: " + data.to_s
        
        @annotation = Annotation.new(transcription_id: meta[:transcription_id], page_id: meta[:page_id], field_group_id: meta[:field_group_id], x_tl: meta[:x_tl], y_tl: meta[:y_tl], width: meta[:width], height: meta[:height])
        @annotation.date_time_id = annotation_params[:obs_date] + "_" + annotation_params[:obs_time]
        
        if data && data.length > 0
          data.each do |key, value|
            @annotation.data_entries.build(page_id: value[:page_id], user_id: value[:user_id], field_id: value[:field_id], data_type: value[:data_type], value: value[:value])
          end
        end
        @annotation.save!
      rescue => e
        error = e.message
      end
    end
    
    if @annotation && @annotation.id
      render json: @annotation.to_json, status: :created
    else
      render json: (@annotation ? @annotation.errors : error), status: :bad_request 
    end
  end

  # PUT /annotations/annotation_id
  # PUT /annotations/annotation_id.json
  def update
    #@annotation is a variable containing an instance of the "annotation.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    error = ""
    Annotation.transaction do
      begin

        @annotation = Annotation.find(params[:id])
        meta = params[:annotation][:meta]

        @annotation.update(x_tl: meta[:x_tl], y_tl: meta[:y_tl], width: meta[:width], height: meta[:height])
      rescue => e 
        error = e.message
      end
    end


    if @annotation && @annotation.x_tl
      render json: @annotation.to_json, status: :created
    else
      render json: (@annotation ? @annotation.errors : error), status: :bad_request 
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
  
  private
  def annotation_params
    params.require(:annotation).permit(:obs_date, :obs_time, :week_day)
  end
end
