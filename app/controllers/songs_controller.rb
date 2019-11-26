class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id]) #if artist does not exist and artist id exist 
      redirect_to artists_path, alert: "Artist not found" # show flash alert and redir artist path 
    else
      @song = Song.new(artist_id: params[:artist_id]) #set artist to id params 
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end


  def edit
    if params[:artist_id] #is there something in the params 
      artist = Artist.find_by(id: params[:artist_id]) #set artist to artist params 
      if artist.nil? #is there an artist there 
        redirect_to artists_path, alert: "Artist not found" #so there isnt show flash alert and then redir artist path 
      else
        @song = artist.songs.find_by(id: params[:id]) #set artist to artist params id 
        redirect_to artist_songs_path(artist), alert: "Song not found" if @song.nil? #then show flash alert and redir them to artist path  
      end
    else
      @song = Song.find(params[:id]) #set song to params id 
    end
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

