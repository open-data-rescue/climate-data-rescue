class FieldOptionsController < ApplicationController
  respond_to :html, :json, :js

  def show
    set_field_option
  rescue => e
    flash[:danger] = e.message
  end

  def edit
    set_field_option
  rescue => e
    flash[:danger] = e.message
  end

  def update
    if current_user && current_user.admin?
      
      FieldOption.transaction do
        begin
          #@field_option is a variable containing an instance of the "FieldOption.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
          @field_option = FieldOption.find(params[:id])
          params[:field_option][:field_ids] ||= []
          @field_option.field_ids = params[:field_option][:field_ids]
          @field_option.save!
          
        rescue => e
          flash[:danger] = e.message
        end
      end

      respond_to do |format|
        if @field_option.update_attributes(field_option_params)
          format.html { redirect_to @field_option, notice: 'FieldOption was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @field_option.errors, status: :unprocessable_fieldOption }
        end
      end
      
    else
      flash[:danger] = 'Only users can modify fieldOptions! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  def create
    if current_user && current_user.admin?
      
      FieldOption.transaction do
        begin
          #@field_Option is a variable containing an instance of the "FieldOption.rb" model created with data passed in the params of the "new.html.slim" form submit action.
          @field_option = FieldOption.create!(field_option_params)
           params[:field_option][:field_ids] ||= []
          @field_option.field_ids = params[:field_option][:field_ids]
          @field_option.save!
        rescue => e
          flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @field_option && @field_option.id
          format.html { redirect_to @field_option, notice: 'FieldOption was successfully created.' }
          format.json { render json: @field_option, status: :created, location: @field_option }
        else
          format.html { render action: "new" }
          format.json { render json: @field_option.errors, status: :unprocessable_fieldOption }
        end
      end
      
    else
      flash[:danger] = 'Only users can modify fieldOptions! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  def new
    @field_option = FieldOption.new
  end

  def index
    @field_options = FieldOption.all
  end

  def destroy
    if current_user && current_user.admin?
      
      FieldOption.transaction do
        begin
          #this function is called to delete the instance of "FieldOption.rb" identified by the fieldOption_id passed to the destroy function when it was called
          @field_option = FieldOption.find(params[:id])
          @field_option.destroy
        rescue => e
          flash[:danger] = e.message
        end
      end

      respond_to do |format|
        format.html { redirect_to field_options_url }
        format.json { head :no_content }
      end
    else
      flash[:danger] = 'Only users can modify field groups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
      redirect_to root_path
    end
  end

  protected

  def set_field_option
    @field_option = FieldOption.find params[:id]
  end

  def field_option_params
    params.require(:field_option).permit(:name, :image, :field_ids, :help, :position)
  end
end