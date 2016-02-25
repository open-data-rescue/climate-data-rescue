class PagetypesController < ApplicationController
  # load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "pagetype" model, pagetype.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the pagetype model
  # All .html.slim views for "pagetype.rb" are located at "project_root\app\views\pagetypes"

  # GET /pagetypes
  # GET /pagetypes.json
  def index
    #@pagetypes is the variable containing all instances of the "pagetype.rb" model passed to the pagetype view "index.html.slim" (project_root/pagetypes) and is used to populate the page with information about each pagetype using @pagetypes.each (an iterative loop).
    if current_user && current_user.admin?
      @pagetypes = Pagetype.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @pagetypes }
      end
    else
      flash[:danger] = 'Only administrators can modify pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /pagetypes/pagetype_id
  # GET /pagetypes/pagetype_id.json
  def show
    if current_user
      #@pagetype is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "show.html.slim" (project_root/pagetypes/pagetype_id) and is used to populate the page with information about the pagetype instance.
      @pagetype = Pagetype.find(params[:id])
      @pages = Page.all
      respond_to do |format|
        format.html # show.html.erb
        #format.json { render json: @pagetype }
        format.json {
          render :json => @page.pagetype.to_json(:include => { :fieldgroups => { :include => :fields }})
        }
      end
    else
      flash[:danger] = 'Only users can view pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /pagetypes/new
  # GET /pagetypes/new.json
  def new
    if current_user && current_user.admin?
      
      Pagetype.transaction do
        begin
          #@pagetype is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "new.html.slim" (project_root/pagetypes/new) and is used to populate the page with information about the pagetype instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new pagetype instance.
          @pagetype = Pagetype.new
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @pagetype }
      end
      
    else
      flash[:danger] = 'Only administrators can modify pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /pagetypes/pagetype_id/edit
  def edit
    if current_user && current_user.admin?
      Pagetype.transaction do
        begin
          #@pagetype is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "edit.html.slim" (project_root/pagetypes/edit) and is used to populate the page with information about the pagetype instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent pagetype instance.
          @pagetype = Pagetype.find(params[:id])
        rescue => e
          # flash[:danger] = e.message
        end
      end
    else
      flash[:danger] = 'Only administrators can modify pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # POST /pagetypes
  # POST /pagetypes.json
  def create
    # raise params.inspect.to_s
    if current_user && current_user.admin?
      
      Pagetype.transaction do  
        begin
          #@pagetype is a variable containing an instance of the "pagetype.rb" model created with data passed in the params of the "new.html.slim" form submit action.
          @pagetype = Pagetype.new(pagetype_params)
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @pagetype.save
          format.html { redirect_to @pagetype, notice: 'Pagetype was successfully created.' }
          format.json { render json: @pagetype, status: :created, location: @pagetype }
        else
          format.html { render action: "new" }
          format.json { render json: @pagetype.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    else
      flash[:danger] = 'Only administrators can modify pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # PUT /pagetypes/pagetype_id
  # PUT /pagetypes/pagetype_id.json
  def update
    if current_user && current_user.admin?
      
      Pagetype.transaction do  
        begin
          #@pagetype is a variable containing an instance of the "pagetype.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
          @pagetype = Pagetype.find(params[:id])
          #respond_with @pagetype if @pagetype.save
        rescue => e
          # flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @pagetype.update_attributes(pagetype_params)
          format.html { redirect_to @pagetype, notice: 'Pagetype was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @pagetype.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    else
      flash[:danger] = 'Only administrators can modify pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
    
  end

  # DELETE /pagetypes/pagetype_id
  # DELETE /pagetypes/pagetype_id.json
  def destroy
    #this function is called to delete the instance of "pagetype.rb" identified by the pagetype_id passed to the destroy function when it was called
    if current_user && current_user.admin?
      
      Pagetype.transaction do  
        begin
          @pagetype = Pagetype.find(params[:id])
          @pagetype.destroy
        rescue => e
          # flash[:danger] = e.message
        end
      end

      respond_to do |format|
        format.html { redirect_to pagetypes_url }
        format.json { head :no_content }
      end
      
    else
      flash[:danger] = 'Only administrators can modify pagetypes! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end
  
  private
  def pagetype_params
    params.require(:pagetype).permit(:description, :title, :ledger_id)
  end
end
