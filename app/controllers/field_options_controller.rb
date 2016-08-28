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
          @field_option.update_attibutes(field_option_params)
          if params[:image]
            @field_option.image = params[:image]
          end

          params[:field_option][:field_ids] ||= []
          @field_option.field_ids = params[:field_option][:field_ids]
          @field_option.save!
          
        rescue => e
          flash[:danger] = e.message
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
          if params[:image]
            @field_option.image = params[:image]
          end
           params[:field_option][:field_ids] ||= []
          @field_option.field_ids = params[:field_option][:field_ids] if params[:field_option][:field_ids].present?
          @field_option.save!
        rescue => e
          flash[:danger] = e.message
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

  def add_to_field
    if params[:field_option_id].present? && params[:field_id].present?
      begin
        @field_option = FieldOption.find params[:field_option_id]
        @field = Field.find params[:field_id]

        FieldOptionsField.create!(field_option_id: params[:field_option_id], field_id: params[:field_id])
      rescue => e
        flash[:danger] = e.message
      end

      # render json: {}
    end
  end

  def remove_from_field
    if params[:field_option_id].present? && params[:field_id].present?
      begin
        @field_option = FieldOption.find params[:field_option_id]
        @field = Field.find params[:field_id]
        @fof = FieldOptionsField.find_by(field_option_id: params[:field_option_id], field_id: params[:field_id])
        @fof.destroy if @fof
      rescue => e
        flash[:danger] = e.message
      end

      # render json: {}
    end
  end

  def index
    begin
      @field_options = FieldOption.all
      if params[:field_id].present?
        @field = Field.find params[:field_id]
        @field_options = @field_options.select{|fo| !fo.fields.include?(@field) }
      end
    rescue => e
      flash[:danger] = e.message
    end
  end

  def for_field
    begin
      if params[:field_id].present?
        @field = Field.find params[:field_id]
        search = params[:search] ? params[:search] : nil

        if search
          @field_options = @field.field_options.where(["value like :q or name like :q or help like :q", :q => ("%" + search + "%")])
        else
          @field_options = @field.field_options
        end
      end
    rescue => e
      flash[:danger] = e.message
    end

    render "index"
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
    params.require(:field_option).permit(:name, :image, :field_ids, :help, :image, :value)
  end
end