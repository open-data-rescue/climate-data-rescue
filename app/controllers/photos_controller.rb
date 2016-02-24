class PhotosController < ApplicationController
  #load_and_authorize_resource :photo
  respond_to :html, :json, :js
  #This Controller is included as an additional feature to allow for the creation of photo objects on the site. for future implementation. Corresponds to the "photo" model, photo.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the photo model
  # All .html.slim views for "photo.rb" are located at "project_root\app\views\photos"
  def index
    
  end

  def new
  end

  def create
    #Create a new photo instance using the data passed to params by the photo creation form, then upon sucessful creation redirect the user to the page showing the new photo. Photos are associated with an album before creation using the same form.
    @photo = Photo.new(photo_params)
    respond_with(@photo, location: photo_path(@photo)) if @photo.save
  end

  def show
  end

  def edit
    #photo attributes are updated using the same form as for creation. If the form is called on an instance of a model, it updates its attributes instead of creating a new form. Upon form submit, the actions of the "create" function are invoked.
  end

  def update
    @photo.update_attributes(photo_params)
    respond_with @photo if @photo.save
  end
  def destroy
    respond_with(@photo) if @photo.destroy
  end
  
  private
  def photo_params
    params.require(:photo).permit(:album_id, :name, :upload)
  end
end