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
          if @page && @page.has_metadata? && create_transcription?
            @transcription = create_transcription(@page)
          end

          if create_transcription? && @transcription
            redirect_to edit_transcription_path(@transcription)
          elsif @page
            if current_user.admin?
              flash[:success] = I18n.t('page-metadata.creation-success')
              redirect_to admin_page_path(@page)
            else
              flash[:danger] = I18n.t('errors.something-went-wrong')
              redirect_to transcribe_page_url(:current_page_id => @page.id)
            end
          else
            flash[:danger] = I18n.t('errors.something-went-wrong')
            redirect_to :back
          end
        rescue => e
          flash[:danger] = e.message
          redirect_to :back
        end
      end
    end
  end

  def update
    if params[:page_id]
      Page.transaction do
        begin
          @page = Page.find params[:page_id]
          
          if @page && @page.has_metadata?
            days = params[:days]
            
            days.each do |key, value|
              id = value["id"]

              if id.present?
                page_day = @page.page_days.find id
                page_day.update({
                  date: value["date"], 
                  num_observations: value["num_observations"]
                })
              end
            end
          end 

          @transcription = nil
          if @page && @page.has_metadata? && create_transcription?
            @transcription = create_transcription(@page)
          end

          if create_transcription? && @transcription
            redirect_to edit_transcription_path(@transcription)
          elsif @page
            if current_user.admin?
              flash[:success] = I18n.t('page-metadata.update-success')
              redirect_to admin_page_path(@page)
            else
              flash[:danger] = I18n.t('errors.something-went-wrong')
              redirect_to transcribe_page_url(:current_page_id => @page.id)
            end
          else
            flash[:danger] = I18n.t('errors.something-went-wrong')
            redirect_to :back
          end
        rescue => e
          flash[:danger] = e.message
          redirect_to :back
        end
      end
    end
  end


  private
  def create_transcription page
    transcription = Transcription.create!(page_id: page.id, user_id: current_user.id) if page && page.id && current_user.present?
    transcription
  end

  def create_transcription?
    params['create_transcription'].present? && (params['create_transcription'] || params['create_transcription'] == 'true')
  end

end