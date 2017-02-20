module Admin
  class ContentImagesController < AdminController
    # TODO: Restrict CRUD access to admins
    # TODO: Handle errors

    def index
      @content_images = ContentImage.all
    end

    def show
      @content_image = ContentImage.find(params[:id])
    end

    def edit
      @content_image = ContentImage.find(params[:id])
    end

    def new
      @content_image = ContentImage.new
    end

    def create
      begin
        @content_image = ContentImage.create!(content_image_params)
      rescue => e
        flash[:danger] = e.message
      end

      if @content_image.present? && @content_image.id
          redirect_to admin_content_images_path
      else
          redirect_to :back
      end

    end

    def update
      @content_image = ContentImage.find(params[:id])
      @content_image.update(content_image_params)

      redirect_to admin_content_image_path(@content_image)
    end

    def destroy
      @content_image = ContentImage.find(params[:id])

      @content_image.destroy if @content_image

      redirect_to admin_content_images_path
    end

    private
    def content_image_params
      params.require(:content_image).permit(:id, :name, :image)
    end
  end
end