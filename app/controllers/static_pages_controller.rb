class StaticPagesController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :render_404
  respond_to :html, :json

  def index
    @static_pages = StaticPage.all
  end

  def new
    @static_page = StaticPage.new
  end

	def show
    @page = StaticPage.visible.find_by!(slug: request.path)
  end

  def create
  	if current_user && current_user.admin?
    	StaticPage.transaction do
    		begin
          @static_page = nil
          @static_page = StaticPage.create!(static_page_params)
    		rescue => e
    			flash[:danger] = e.message
				end
    	end

      respond_to do |format|
        if @static_page && @static_page.id
          flash[:info] = 'Content Page created successfully!'
          format.html { redirect_to static_pages_path }
        else
          format.html { redirect_to new_static_page_path }
        end
      end
  	else
      flash[:danger] = 'Only admins can create pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
	  end
  end

  def update
    if current_user && current_user.admin?
      StaticPage.transaction do
        begin
          @static_page = nil
          @static_page = StaticPage.find params[:id]
          @static_page.update(static_page_params)
        rescue => e
          flash[:danger] = e.message
        end
      end

      respond_to do |format|
        if @static_page && @static_page.id
          flash[:info] = 'Content Page updated successfully!'
          format.html { redirect_to static_pages_path }
        else
          format.html { redirect_to :back }
        end
      end
    else
      flash[:danger] = 'Only admins can update pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  def edit
    if current_user && current_user.admin?
      begin
        @static_page = StaticPage.find(params[:id])
      rescue => e
        flash[:danger] = e.message
      end
    else
      flash[:danger] = 'Only admins can update pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  private
  def static_page_params
  	params.require(:static_page).permit(:title, :body, :slug, :show_in_header, :show_in_sidebar, :visible, :foreign_link, :position, :meta_keywords, :meta_title, :meta_description)
  end

  def accurate_title
    @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
  end
end