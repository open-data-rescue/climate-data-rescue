module Admin
  class AdminController < ApplicationController
    before_action :ensure_admin






    protected
    def ensure_admin
      unless current_user && current_user.admin?
        flash[:alert] = I18n.t('admin-access-only-error-msg')
        redirect_to root_path
      end
    end

    private
    def landing
        
    end
  end
end