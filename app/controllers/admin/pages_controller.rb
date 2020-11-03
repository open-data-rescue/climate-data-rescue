module Admin
  class PagesController < AdminController
    # load_and_authorize_resource
    respond_to :html, :json, :js
    #Corresponds to the "page" model, page.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the page model
    #All .html.slim views for "page.rb" are located at "project_root\app\views\pages"
    # GET /pages
    # GET /pages.json
    def index
      @pages = Page.includes(:page_type, :page_days).paginate(
        page: page_number,
        per_page: per_page
      )
      page_ids = @pages.pluck(:id)

      @page_days = PageDay.where(page_id: page_ids).order("date ASC").to_a
      @transcriptions = Transcription.where(page_id: page_ids).includes(:user).order("updated_at DESC").to_a
      @users = User.where(id: @transcriptions.pluck(:user_id).uniq).to_a

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @pages }
      end
    end

    # GET /pages/page_id
    # GET /pages/page_id.json
    def show
      @page = Page.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @page }
      end
    end

    # GET /pages/new
    # GET /pages/new.json
    def new
      @page = Page.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @page }
      end
    end

    # GET /pages/page_id/edit
    def edit
      Page.transaction do
        begin
            @page = Page.find(params[:id])
        rescue => e
          flash[:danger] = e.message
        end
      end
    end

    # POST /pages
    # POST /pages.json
    def create
      Page.transaction do
        raise "no image detected" unless params[:page][:image].present?
        upload = params[:page][:image]
        Rails.logger.debug upload unless Rails.env.production?

        if upload.is_a? Array
          image = upload[0]
        else
          image = upload
        end

        filename = image.original_filename
        page = Page.find_by(image_file_name: filename)
        if page.present?
          page.image = image
          page.save!
        else
          page = Page.create!(image: image, visible: false)
        end
        respond_to do |format|
          format.html { #(html response is for browsers using iframe solution)
            render :json => [page.to_jq_upload].to_json,
            :content_type => 'text/html',
            :layout => false
          }
          format.json {
            render :json => {files: [page.to_jq_upload] }.to_json
          }
        end
      end
    rescue => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join("\n\t")
      respond_to do |format|
        format.html do
          flash[:error] = ex.message
          redirect_to new_admin_page_path
        end
        format.json do
          render status: :bad_request, text: ex.message
        end
      end
    end

    # PUT /pages/page_id
    # PUT /pages/page_id.json
    def update
      Page.transaction do
        begin
          @page = Page.find(params[:id])
          if @page.width.nil?
            @page.extract_dimensions
          end
        rescue => ex
          Rails.logger.error ex.message
          Rails.logger.error ex.backtrace.join("\n\t")
          flash[:danger] = ex.message
        end

        respond_to do |format|
          if @page.update_attributes(page_params)
            format.html { redirect_to admin_page_path(@page), success: 'Page was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @page.errors, status: :unprocessable_fieldgroup }
          end
        end
      end
    end

    def for_transcription
      if params[:transcription_id].present?
        begin
          @transcription = Transcription.find(params[:transcription_id])
          @page = @transcription.page
        rescue => e

        end
      end
    end

    # DELETE /pages/page_id
    # DELETE /pages/page_id.json
    def destroy
      Page.transaction do
          page = Page.find(params[:id])
          page.destroy!
      end

      respond_to do |format|
        format.html { redirect_to admin_pages_path }
        format.json { render :json => true }
      end
    end

    private

    def page_params
      params.require(:page).permit(:height, :order, :width, :page_type_id, :image, 
        :title, :accession_number, :start_date, :start_date, :page_type, :volume,
        :visible, :done)
    end

    def page_number
      params[:page] || 1
    end

    def per_page
      params[:per_page] || 10
    end
  end
end