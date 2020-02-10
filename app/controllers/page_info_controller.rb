class PageInfoController < ApplicationController
  before_action :ensure_current_user
  
  def create
    if params[:page_id]
      Page.transaction do
        begin
          @page = Page.find params[:page_id]
          
         if @page && !@page.page_metadata?
            observer = params[:observer]
            location = params[:location]
            lat = params[:lat]
            lon = params[:lon]
            elevation = params[:elevation]
            page_id= params[:page_id]
            @page.create_page_info({observer: observer, lat: lat, lon: lon, location: location, page_id: page_id, elevation: elevation,user_id: current_user.id})
  
          end
          

        end
      end
    end
  end

  def update
    if params[:page_id]
      Page.transaction do
        begin
          @page = Page.find params[:page_id]
          
          if @page && @page.page_metadata?
            observer = params[:observer]
            location = params[:location]
            lat = params[:lat]
            lon = params[:lon]
            elevation = params[:elevation]
            @page.page_info.update({observer: observer, lat: lat, lon: lon, location: location, elevation: elevation, user_id: current_user.id})
            
          end 

        end
      end
    end
  end



end
