class ContentImagesController < ApplicationController
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
    @content_image = ContentImage.new(content_image_params)

    unless content_image_params[:image].nil?
        if @content_image.save!
            redirect_to :content_images
        else
            render :new
        end 
    end

  end

  def update
    @content_image = ContentImage.find(params[:id])
    @content_image.update(content_image_params)

    redirect_to content_image_path(@content_image)
  end

  def destroy
    @content_image = ContentImage.find(params[:id])

    @content_image.destroy if @content_image

    redirect_to :content_images
  end

  private
  def content_image_params
    params.require(:content_image).permit(:id, :name, :image)
  end
end
