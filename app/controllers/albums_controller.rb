class AlbumsController < ApplicationController
  before_action :authenticate_user! , only: %i[show edit update destroy]
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :set_search

  
  # GET /albums or /albums.json
  def index
    @q = Album.ransack(params[:q])
    @albums = @q.result(distinct: true).includes(:tags).where(published:true) # Include associated tags to avoid N+1 queries
  end


  def new
    @album = current_user.albums.build
  end

  # GET /albums/1 or /albums/1.json
  def show
  end

  # GET /albums/new
  

  # GET /albums/1/edit
  def edit
    
  end

  # POST /albums or /albums.json
  def create
    @album = current_user.albums.build(album_params)

    @album.published = params[:album][:published] == '1'


    respond_to do |format|
      if @album.save
        format.html { redirect_to album_url(@album), notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end


  def search
    @q = Album.ransack(params[:q])
    @albums = @q.result(distinct: true)
    render :index
  end

  def publish
  @album = current_user.albums.find(params[:id])
  @album.update(published: true)
  redirect_to albums_path, notice: 'Album published successfully.'
  end


  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to album_url(@album), notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album = Album.find(params[:id])

    @album.taggings.destroy_all
    
    @album.destroy
  
    # Destroy associated rich text content
    
    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_description }
    end
  end
    


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title, :description, :published, :price , :all_tags , :audio , :profile_image)
    end

    def set_search
      @q = Album.ransack(params[:q])
    end
end
