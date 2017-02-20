module Admin
  class PageTypesController < AdminController
    # load_and_authorize_resource
    respond_to :html, :json, :js
    #Corresponds to the "pagetype" model, pagetype.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the pagetype model
    # All .html.slim views for "pagetype.rb" are located at "project_root\app\views\page_types"

    # GET /page_types
    # GET /page_types.json
    def index
      #@page_types is the variable containing all instances of the "pagetype.rb" model passed to the pagetype view "index.html.slim" (project_root/page_types) and is used to populate the page with information about each pagetype using @page_types.each (an iterative loop).
      if current_user && current_user.admin?
        @page_types = PageType.all

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @page_types }
        end
      else
        flash[:danger] = 'Only administrators can modify page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /page_types/pagetype_id
    # GET /page_types/pagetype_id.json
    def show
      if current_user
        #@page_type is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "show.html.slim" (project_root/page_types/pagetype_id) and is used to populate the page with information about the pagetype instance.
        @page_type = PageType.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          #format.json { render json: @page_type }
          format.json {
            render :json => @pagetype.to_json(:include => { :fieldgroups => { :include => :fields }})
          }
        end
      else
        flash[:danger] = 'Only users can view page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /page_types/new
    # GET /page_types/new.json
    def new
      if current_user && current_user.admin?
        @page_type = PageType.new
        
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @page_type }
        end
        
      else
        flash[:danger] = 'Only administrators can modify page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /page_types/pagetype_id/edit
    def edit
      if current_user && current_user.admin?
        PageType.transaction do
          begin
            #@page_type is a variable containing an instance of the "pagetype.rb" model. It is passed to the pagetype view "edit.html.slim" (project_root/page_types/edit) and is used to populate the page with information about the pagetype instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent pagetype instance.
            @page_type = PageType.find(params[:id])
          rescue => e
            flash[:danger] = e.message
          end
        end
      else
        flash[:danger] = 'Only administrators can modify page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # POST /page_types
    # POST /page_types.json
    def create
      # raise params.inspect.to_s
      if current_user && current_user.admin?
        
        PageType.transaction do  
          begin
            #@page_type is a variable containing an instance of the "pagetype.rb" model created with data passed in the params of the "new.html.slim" form submit action.
            @page_type = PageType.create!(pagetype_params)

            params[:page_type][:field_group_ids] ||= []
            @page_type.field_group_ids = params[:page_type][:field_group_ids]
            @page_type.save!
          rescue => e
            flash[:danger] = e.message
          end
        end
        
        respond_to do |format|
          if @page_type && @page_type.id
            format.html { redirect_to admin_page_type_path(@page_type), notice: 'Pagetype was successfully created.' }
            format.json { render json: @page_type, status: :created, location: @page_type }
          else
            format.html { render action: "new" }
            format.json { render json: @page_type.errors, status: :unprocessable_page_type }
          end
        end
        
      else
        flash[:danger] = 'Only administrators can modify page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # PUT /page_types/pagetype_id
    # PUT /page_types/pagetype_id.json
    def update
      if current_user && current_user.admin?
        
        PageType.transaction do  
          begin
            #@page_type is a variable containing an instance of the "pagetype.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
            @page_type = PageType.find(params[:id])
            params[:page_type][:field_group_ids] ||= []
            @page_type.field_group_ids = params[:page_type][:field_group_ids]
            @page_type.save!
          rescue => e
            flash[:danger] = e.message
          end
        end
        
        respond_to do |format|
          if @page_type.update_attributes(pagetype_params)
            format.html { redirect_to admin_page_type_path(@page_type), notice: 'Pagetype was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @page_type.errors, status: :unprocessable_fieldgroup }
          end
        end
        
      else
        flash[:danger] = 'Only administrators can modify page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
      
    end

    # DELETE /page_types/pagetype_id
    # DELETE /page_types/pagetype_id.json
    def destroy
      #this function is called to delete the instance of "pagetype.rb" identified by the pagetype_id passed to the destroy function when it was called
      if current_user && current_user.admin?
        
        PageType.transaction do  
          begin
            @page_type = PageType.find(params[:id])
            @page_type.destroy
          rescue => e
            # flash[:danger] = e.message
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_page_types_path }
          format.json { head :no_content }
        end
        
      else
        flash[:danger] = 'Only administrators can modify page_types! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end
    
    private
    def pagetype_params
      params.require(:page_type).permit(:title, :type, :description, :ledger_id)
    end
  end
end