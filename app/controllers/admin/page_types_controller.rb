module Admin
  class PageTypesController < AdminController
    # load_and_authorize_resource
    respond_to :html, :json, :js
    #Corresponds to the "page_schema" model, page_schema.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the page_schema model
    # All .html.slim views for "page_schema.rb" are located at "project_root\app\views\page_types"

    # GET /page_types
    # GET /page_types.json
    def index
      @page_types = PageType.order(:title)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @page_types }
      end
    end

    # GET /page_types/page_schema_id
    # GET /page_types/page_schema_id.json
    def show
      @page_type = PageType.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json {
          render :json => @page_schema.to_json(:include => { :fieldgroups => { :include => :fields }})
        }
      end
    end

    # GET /page_types/new
    # GET /page_types/new.json
    def new
      @page_type = PageType.new
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @page_type }
      end
    end

    # GET /page_types/page_schema_id/edit
    def edit
      PageType.transaction do
        begin
          @page_type = PageType.find(params[:id])
        rescue => e
          flash[:danger] = e.message
        end
      end
    end

    # POST /page_types
    # POST /page_types.json
    def create
      PageType.transaction do  
        begin
          @page_type = PageType.create!(page_schema_params)

          params[:page_type][:field_group_ids] ||= []
          @page_type.field_group_ids = params[:page_type][:field_group_ids]
          @page_type.save!
        rescue => e
          flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @page_type && @page_type.id
          format.html { redirect_to admin_page_type_path(@page_type), success: 'Page Schema was successfully created.' }
          format.json { render json: @page_type, status: :created, location: @page_type }
        else
          format.html { render action: "new" }
          format.json { render json: @page_type.errors, status: :unprocessable_page_type }
        end
      end
    end

    # PUT /page_types/page_schema_id
    # PUT /page_types/page_schema_id.json
    def update
      PageType.transaction do  
        begin
          @page_type = PageType.find(params[:id])
        rescue => e
          flash[:danger] = e.message
        end
      end
      
      respond_to do |format|
        if @page_type.update(page_schema_params)
          format.html { redirect_to admin_page_type_path(@page_type), success: 'Page Schema was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @page_type.errors, status: :unprocessable_fieldgroup }
        end
      end
      
    end

    # DELETE /page_types/page_schema_id
    # DELETE /page_types/page_schema_id.json
    def destroy
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
    end
    
    private
    def page_schema_params
      params.require(:page_type).permit(:title, :type, :description, :ledger_id, :visible)
    end
  end
end