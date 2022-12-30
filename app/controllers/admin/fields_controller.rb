module Admin
  class FieldsController < AdminController
    #load_and_authorize_resource
    respond_to :html, :json, :js
    #Corresponds to the "field" model, field.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the field model
    #All .html.slim views for "field.rb" are located at "project_root\app\views\fields"
    # GET /fields
    # GET /fields.json
    # this sets up the data for the view using the index method
    def index
      #@fields is the variable containing all instances of the "field.rb" model passed to the field view "index.html.slim" (project_root/fields) and is used to populate the page with information about each field using @fields.each (an iterative loop).
      # checks that the user is an admin
      if current_user && current_user.admin?
      	# finds all fields and includes all page types and field groups in data that are returned
        @fields = Field.includes(:page_types, :field_groups).all
        # look for results of requested field group
        if params[:field_group_id].present?
          @field_group = FieldGroup.find params[:field_group_id]
          @fields = @fields.select{|field| !field.field_groups.include?(@field_group) }
        end
        # sets views for data set
        respond_to do |format|
          format.html # index.html.erb
          format.json
        end
      else
        flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /fields/field_id
    # GET /fields/field_id.json
    def show
      #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "show.html.slim" (project_root/fields/field_id) and is used to populate the page with information about the field instance.
      if current_user && current_user.admin?
        @field = Field.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @field }
        end

      else
        flash[:danger] = 'Only administrators can view fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /fields/new
    # GET /fields/new.json
    def new
      if current_user && current_user.admin?
        Field.transaction do
          begin
            #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "new.html.slim" (project_root/fields/new) and is used to populate the page with information about the field instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new field instance.
            @field = Field.new
          rescue => e
            # flash[:danger] = e.message
          end
        end

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @pagetype }
        end

      else
        flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /fields/field_id/edit
    def edit
      if current_user && current_user.admin?
        Field.transaction do
          begin
            #@field is a variable containing an instance of the "field.rb" model. It is passed to the field view "edit.html.slim" (project_root/fields/edit) and is used to populate the page with information about the field instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent field instance.
            @field = Field.find(params[:id])
          rescue => e
            # flash[:danger] = e.message
          end
        end

      else
        flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # POST /fields
    # POST /fields.json
    def create
      if current_user && current_user.admin?

        Field.transaction do
          begin
            #@field is a variable containing an instance of the "field.rb" model created with data passed in the params of the "new.html.slim" form submit action.
            @field = Field.new(field_params)

            if params[:field_group_id]
              @field_group = FieldGroup.find params[:field_group_id]
            end
          rescue => e
            # flash[:danger] = e.message
          end
        end

        respond_to do |format|
          if @field.save
            format.html { redirect_to admin_fields_path, success: 'Field was successfully created.' }
            format.json { render json: @field, status: :created, location: [:admin, @field] }
          else
            format.html { render action: "new" }
            format.json { render json: @field.errors, status: :unprocessable_fieldgroup }
          end
        end

      else
        flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # PUT /fields/field_id
    # PUT /fields/field_id.json
    def update
      if current_user && current_user.admin?

        Field.transaction do
          begin
            #@field is a variable containing an instance of the "field.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action.
            @field = Field.find(params[:id])
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          if @field.update(field_params)
            format.html { redirect_to admin_fields_path, success: 'Field was successfully updated.' }
            format.json
          else
            format.html { render action: "edit" }
            format.json { render json: @field.errors, status: :unprocessable_fieldgroup }
          end
        end

      else
        flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # DELETE /fields/field_id
    # DELETE /fields/field_id.json
    def destroy
      #this function is called to delete the instance of "field.rb" identified by the field_id passed to the destroy function when it was called
      if current_user && current_user.admin?
        Field.transaction do
          begin
            field = Field.find(params[:id])
            field.destroy
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_fields_path }
          format.json { head :no_content }
        end

      else
        flash[:danger] = 'Only administrators can modify fields! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end



    def add_to_field_group
      if params[:field_group_id].present? && params[:field_id].present?
        begin
          @field_group = FieldGroup.find params[:field_group_id]
          @field = Field.find params[:field_id]

          FieldGroupsField.create!(field_group_id: params[:field_group_id], field_id: params[:field_id])
        rescue => e
          flash[:danger] = e.message
        end
      end
    end

    def remove_from_field_group
      if params[:field_group_id].present? && params[:field_id].present?
        begin
          @field_group = FieldGroup.find params[:field_group_id]
          @field = Field.find params[:field_id]
          @fgf = FieldGroupsField.find_by(field_group_id: params[:field_group_id], field_id: params[:field_id])
          @fgf.destroy if @fgf
        rescue => e
          flash[:danger] = e.message
        end
      end
    end

    def update_sort_order
      if params[:field_group_id].present? && params[:field_id].present?
        begin
          @field_group = FieldGroup.find params[:field_group_id]
          @field = Field.find params[:field_id]
          @fgf = FieldGroupsField.find_by(field_group_id: params[:field_group_id], field_id: params[:field_id])
          if @fgf
            @fgf.sort_order_position = params[:sort_order_position]
            @fgf.save
          end
        rescue => e
          flash[:danger] = e.message
        end
      end
    end

    def for_field_group
      begin
        if params[:field_group_id].present?
          @field_group = FieldGroup.find params[:field_group_id]
          search = params[:search] ? params[:search] : nil

          if search
            @fields = @field_group.fields.where(["name like :q or name like :q or help like :q", :q => ("%" + search + "%")])
          else
            @fields = @field_group.fields
          end
        end
      rescue => e
        flash[:danger] = e.message
      end

      render "index"
    end

    private
    def field_params
      params.require(:field).permit(:internal_name, :field_key, :initial_value, :data_type, :html_field_type, :name, :validations, :full_name, :help, :field_group_id, :multi_select, :period, :time_of_day, :measurement_type, :measurement_unit_original, :measurement_unit_si, :odr_type)
    end
  end
end
