class PagesController < ApplicationController
  # load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "page" model, page.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the page model
  #All .html.slim views for "page.rb" are located at "project_root\app\views\pages"
  # GET /pages
  # GET /pages.json
  def index
    #@pages is the variable containing all instances of the "page.rb" model passed to the page view "index.html.slim" (project_root/pages) and is used to populate the page with information about each page using @pages.each (an iterative loop).
    if current_user && current_user.admin?
      @pages = Page.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @pages }
      end
    else
      flash[:danger] = 'Only administrators can modify pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  # GET /pages/page_id
  # GET /pages/page_id.json
  def show
    #@page is a variable containing an instance of the "page.rb" model. It is passed to the page view "show.html.slim" (project_root/pages/page_id) and is used to populate the page with information about the page instance.
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    #@page is a variable containing an instance of the "page.rb" model. It is passed to the page view "new.html.slim" (project_root/pages/new) and is used to populate the page with information about the page instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new page instance.
    if current_user.admin?
      @page = Page.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @page }
      end
    else
      redirect_to root_path, alert: 'Only administrators can modify pages!'
    end
  end

  # GET /pages/page_id/edit
  def edit
    #@page is a variable containing an instance of the "page.rb" model. It is passed to the page view "edit.html.slim" (project_root/pages/edit) and is used to populate the page with information about the page instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent page instance.
    if current_user.admin?
      @page = Page.find(params[:id])
    else
      redirect_to root_path, alert: 'Only administrators can modify pages!'
    end
  end

  # POST /pages
  # POST /pages.json
  def create
    #@page is a variable containing an instance of the "page.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    Page.transaction do
      begin
        @page = Page.new(page_params)
        @page.extract_upload_dimensions
        #respond_with(@page, location: page_path(@page)) if @page.save
        @page.save!
        
      rescue => e
        # flash[:danger] = e.message
      end
      respond_to do |format|
        if @page.id
          format.html { redirect_to @page, notice: 'Page was successfully created.' }
          format.json { render json: @page, status: :created, location: @page }
        else
          format.html { render action: "new" }
          format.json { render json: @page.errors, status: :unprocessable_fieldgroup }
        end
      end
    end
  end

  # PUT /pages/page_id
  # PUT /pages/page_id.json
  def update
    #@page is a variable containing an instance of the "page.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action.
    @page = Page.find(params[:id])
    if @page.width==nil
      @page.extract_dimensions
    end
    @page.set_name_to_filename
    
    #respond_with @page if @page.save
    respond_to do |format|
      if @page.update_attributes(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_fieldgroup }
      end
    end
  end

  # DELETE /pages/page_id
  # DELETE /pages/page_id.json
  def destroy
    #this function is called to delete the instance of "page.rb" identified by the page_id passed to the destroy function when it was called
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
  
  private
  def page_params
    params.require(:page).permit(:classification_count, :display_width, :done, :ext_ref, :height, :order, :width, :pagetype_id, :upload, :name)
  end
end
