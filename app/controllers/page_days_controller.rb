class PageDaysController < ApplicationController
  def create
    if params[:page_id]
      Page.transaction do
        begin
          page = Page.find params[:page_id]
          user_id = params[:user_id]
          
          if page
            days = params[:days]
            
            days.each do |key, value|
              page.page_days.create!(date: value["date"], num_observations: value["num_observations"], user_id: user_id)
            end
          end
          
          transcription = nil
          if page.has_metadata?
            transcription = Transcription.create!(page_id: page.id, user_id: user_id)
            page.transcriber_id = user_id
            page.save!
          end
          
          if transcription && transcription.id
            redirect_to edit_transcription_url(transcription)
          else
            flash[:danger] = "Transcription could not be started. Please try starting it on your own."
            redirect_to transcribe_page_url(:current_page_id => page.id)
          end
          
        rescue => e
          flash[:danger] = e.message
        end
      end
    end
  end
end