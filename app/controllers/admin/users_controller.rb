module Admin
  class UsersController < AdminController
    
    def index
      @users = User.includes(:transcriptions).order('admin desc, created_at asc')
      @transcriptions = transcriptions(@user.id)
    end

    def show
      @user = User.find(params[:id])
      @transcriptions = transcriptions(@user.id)
    end

    def edit
      @user = User.find params[:id]
    end

    def update
      begin
        User.transaction do
          @user = User.find params[:id]
          @user.update_attributes(users_params)
        end
      rescue => e
        flash[:danger] = e.message
      end

      respond_to do |format|
        format.html { redirect_to admin_users_path }
      end
    end
    
    def destroy
      begin
        User.transaction do
          @user = User.find(params[:id])
          @user.destroy
        end
      rescue => e
        flash[:danger] = e.message
      end

      respond_to do |format|
        format.html { redirect_to admin_users_path }
      end
    end

    private

    def transcriptions(user_id)
      Transcription.includes(:user, :page, :annotations, :field_groups, :field_groups_fields, :page_type, annotations: [:data_entries], page: [:page_days, :page_info, :page_type])
        .eager_group(:data_entries_count, {page: :page_days_observation_sum})
        .where(user_id: user_id)
    end

    def users_params
      params.require(:user).permit(:display_name, :admin, :bio)
    end

  end
end
