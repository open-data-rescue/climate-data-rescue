class PagetypesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "pagetype" model, pagetype.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the pagetype model
  # All .html.slim views for "pagetype.rb" are located at "project_root\app\views\pagetypes"

  # GET /pagetypes
  # GET /pagetypes.json
  def index
    #@pagetypes is the variable containing all instances of the "pagetype.rb" model passed to the pagetype view "index.html.slim" (project_root/pagetypes) and is used to populate the page with information about each pagetype using @pagetypes.each (an iterative loop).
    @pagetypes = Pagetype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pagetypes }
    end
  end

  # GET /pagetypes/pagetype_id
  # GET /pagetypes/pagetype_id.json
  def show
    #@pagetype is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "show.html.slim" (project_root/pagetypes/pagetype_id) and is used to populate the page with information about the pagetype instance.
    @pagetype = Pagetype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pagetype }
    end
  end

  # GET /pagetypes/new
  # GET /pagetypes/new.json
  def new
    #@pagetype is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "new.html.slim" (project_root/pagetypes/new) and is used to populate the page with information about the pagetype instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new pagetype instance.
    @pagetype = Pagetype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pagetype }
    end
  end

  # GET /pagetypes/pagetype_id/edit
  def edit
    #@pagetype is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "edit.html.slim" (project_root/pagetypes/edit) and is used to populate the page with information about the pagetype instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent pagetype instance.
    @pagetype = Pagetype.find(params[:id])
  end

  # POST /pagetypes
  # POST /pagetypes.json
  def create
    #@pagetype is a variable containing an instance of the "pagetype.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @pagetype = Pagetype.new(params[:pagetype])

    respond_to do |format|
      if @pagetype.save
        format.html { redirect_to @pagetype, notice: 'Pagetype was successfully created.' }
        format.json { render json: @pagetype, status: :created, location: @pagetype }
      else
        format.html { render action: "new" }
        format.json { render json: @pagetype.errors, status: :unprocessable_fieldgroup }
      end
    end
  end

  # PUT /pagetypes/pagetype_id
  # PUT /pagetypes/pagetype_id.json
  def update
    #@pagetype is a variable containing an instance of the "pagetype.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    @pagetype = Pagetype.find(params[:id])

    @pagetype.author = current_user.email
    respond_with @pagetype if @pagetype.save
    
  end

  # DELETE /pagetypes/pagetype_id
  # DELETE /pagetypes/pagetype_id.json
  def destroy
    #this function is called to delete the instance of "pagetype.rb" identified by the pagetype_id passed to the destroy function when it was called
    @pagetype = Pagetype.find(params[:id])
    @pagetype.destroy

    respond_to do |format|
      format.html { redirect_to pagetypes_url }
      format.json { head :no_content }
    end
  end
end
