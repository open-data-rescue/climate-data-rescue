class AlbumsController < ApplicationController
  #load_and_authorize_resource
  respond_to :html, :json, :js
  #This Controller is included as an additional feature to allow for the creation of photo albums on the site. for future implementation. Corresponds to the "album" model, album.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the album model
  # All .html.slim views for "album.rb" are located at "project_root\app\views\albums"
  def index
    
  end

  def new
    @album = Album.new
  end

  def create
    #Create a new album instance using the data passed to params by the album creation form, then upon sucessful creation redirect the user to the page showing the new album. Photoss are associated with an album using the photo creation/update form..
    @album = Album.new(album_params)
    respond_with(@album, location: album_path(@album)) if @album.save
  end

  def show
  end

  def edit
    #Album attributes are updated using the same form as for creation. If the form is called on an instance of a model, it updates its attributes instead of creating a new form. Upon form submit, the actions of the "create" function are invoked.
  end

  def update
    @album.update_attributes(album_params)
    respond_with @album if @album.save
  end
  def destroy
    respond_with(@album) if @album.destroy
  end
  
  private
  def album_params
    params.require(:album).permit(:name)
  end
end