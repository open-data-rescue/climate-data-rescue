class UsersController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "user" model, user.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the user model
  #All .html.slim views for "user.rb" are located at "project_root\app\views\users"
  def index
    if current_user
      #@users is the variable containing all instances of the "user.rb" model passed to the user view "index.html.slim" (project_root/users) and is used to populate the page with information about each user using @users.each (an iterative loop).
      @users = User.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:danger] = 'Only users can view the user index! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end
  
  def show
    #@user is a variable containing an instance of the "user.rb" model. It is passed to the user view "show.html.slim" (project_root/users/user_id) and is used to populate the page with information about the user instance.
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  

  def edit
      @user = User.find(params[:id])
  end
  
  def stats
    #@user is a variable containing an instance of the "user.rb" model. It is passed to the user view "show.html.slim" (project_root/users/user_id) and is used to populate the page with information about the user instance.
    @user = User.find(params[:id])

    # respond_to do |format|
      # format.html # show.html.erb
      # format.json { render json: @user }
    # end
  end

  def update
    
      User.transaction do
        begin
          #@user is a variable containing an instance of the "user.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
          @user = User.find(params[:id])
          @user.update_attributes(users_params)
          
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

  def destroy
    #this function is called to delete the instance of "user.rb" identified by the user_id passed to the destroy function when it was called
    if current_user && current_user.admin?
      
      User.transaction do
        begin
          @user = User.find(params[:id])
          @user.destroy
        rescue => e
          # flash[:danger] = e.message
        end
      end

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
      
    else
      flash[:danger] = 'Only administrators can modify users! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end
  
  private
  
  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :name, :admin, :avatar, :about, :contributions, :rank)
  end

end