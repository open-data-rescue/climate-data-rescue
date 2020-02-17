class PageInfoController < PageDaysController
  before_action :ensure_current_user
  
  def create
    if params[:page_id]
      Page.transaction do
        begin
          @page = Page.find params[:page_id]
          
          if @page && !@page.page_metadata?
            @page.create_page_info(page_info_params)
          end

          @transcription = nil
          if @page && @page.page_metadata? && create_transcription?
            @transcription = find_transcription(@page, current_user) || create_transcription(@page, current_user)
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
          
          if @page && @page.page_metadata?
            @page.page_info.update(page_info_params)
          end

          @transcription = nil
          if @page && @page.page_days? && create_transcription?
            @transcription = find_transcription(@page, current_user) || create_transcription(@page, current_user)
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

  def page_info_params
    params.require(:page_info).permit(%i[
      observer location elevation lat lon page_id month year
    ])
  end



end
