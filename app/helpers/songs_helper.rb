module SongsHelper
  def artists_select(song, nested)
    if nested
      song.artist.name
    else
      select_tag(:song_artist_id, options_from_collection_for_select(Artist.all, :id, :name))
    end
  end
end
