class PageDaysController < ApplicationController
  before_action :ensure_current_user
  
  def create
    if params[:page_id]
      Page.transaction do
        begin
          @page = Page.find params[:page_id]
          
          if @page && !@page.has_metadata?
            days = params[:days]
            
            days.each do |key, value|
              @page.page_days.create!(date: value["date"], num_observations: value["num_observations"], user_id: current_user.id)
            end
          end
          
          @transcription = nil
          if @page && @page.has_metadata?
            @transcription = Transcription.create!(page_id: @page.id, user_id: current_user.id)
          end
          
        rescue => e
          flash[:danger] = e.message
        end
      end
          
      if @transcription
        redirect_to edit_transcription_path(@transcription)
      elsif @page
        flash[:danger] = I18n.t('errors.something-went-wrong')
        redirect_to transcribe_page_url(:current_page_id => @page.id)
      else
        redirect_to :back
      end
    end
  end
end