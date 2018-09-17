class UsersController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  before_action :ensure_current_user
  #Corresponds to the "user" model, user.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the user model
  #All .html.slim views for "user.rb" are located at "project_root\app\views\users"

  def my_profile
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def show
    #@user is a variable containing an instance of the "user.rb" model. It is passed to the user view "show.html.slim" (project_root/users/user_id) and is used to populate the page with information about the user instance.
    @user = User.includes(
      {
        transcriptions: [
          { 
            page: [
              :page_days
            ] 
          },
          :annotations
        ]
      },
      :data_entries
    ).find(params[:id])

    render "my_profile"
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    User.transaction do
      begin
        #@user is a variable containing an instance of the "user.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
        @user = User.find(params[:id])
        @user.update(users_params)
        
      rescue => e
        flash[:danger] = e.message
      end
    end
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, success: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def dismiss_box_tutorial
    if current_user
      begin
        current_user.dismissed_box_tutorial = true
        current_user.save!
        render status: :ok, text: {}.to_json
      rescue => e
        render status: :bad_request, text: e.message
      end
    end
  end
  
  private
  
  def users_params
    params.require(:user).permit(:email, :name, :admin, :avatar, :bio)
  end

end