class PagesController < ApplicationController
  # load_and_authorize_resource
  respond_to :html, :json
  #Corresponds to the "page" model, page.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the page model
  #All .html.slim views for "page.rb" are located at "project_root\app\views\pages"
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.unseen(current_user).inactive.transcribeable
    @user_transcriptions = current_user ? current_user.transcriptions : []
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
end
