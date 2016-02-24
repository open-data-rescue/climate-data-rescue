class UsersController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  #Corresponds to the "user" model, user.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the user model
  #All .html.slim views for "user.rb" are located at "project_root\app\views\users"
  def index
    #@users is the variable containing all instances of the "user.rb" model passed to the user view "index.html.slim" (project_root/users) and is used to populate the page with information about each user using @users.each (an iterative loop).
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def create
    #@user is a variable containing an instance of the "user.rb" model created with data passed in the params of the "new.html.slim" form submit action.
    @user = User.new(users_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to "/new-user", notice: 'User creation failed!' }
        format.json { render json: @user.errors, status: :unprocessable_fieldgroup }
      end
    end

  end

  def new
    #@user is a variable containing an instance of the "user.rb" model. It is passed to the user view "new.html.slim" (project_root/users/new) and is used to populate the page with information about the user instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new user instance.
    if current_user && current_user.admin?
      @user = User.new

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
      end
    else
      redirect_to root_path, error: 'Only administrators can create users!'
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
    #@user is a variable containing an instance of the "user.rb" model. It is passed to the user view "edit.html.slim" (project_root/users/edit) and is used to populate the page with information about the user instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent user instance.
    if current_user && current_user.admin? || current_user.id == @user.id
      @user = User.find(params[:id])
    else
      redirect_to root_path, alert: 'Only administrators can modify users!'
    end
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
    #@user is a variable containing an instance of the "user.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(users_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_fieldgroup }
      end
    end
    
  end

  def destroy
    #this function is called to delete the instance of "user.rb" identified by the user_id passed to the destroy function when it was called
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :name, :admin, :avatar, :about, :contributions, :rank)
  end

end