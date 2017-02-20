module Admin
  class UsersController < AdminController
    
    def index
      @users = User.all
    end

    def show
      @user = User.find params[:id]
    end
    
    def destroy
      User.transaction do
          begin
            @user = User.find(params[:id])
            @user.destroy
          rescue => e
            flash[:danger] = e.message
          end
      end

      respond_to do |format|
        format.html { redirect_to admin_users_path }
      end
    end

  end
end