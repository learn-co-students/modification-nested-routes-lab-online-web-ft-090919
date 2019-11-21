module SongsHelper

  def artist_id_field(song, artists = [])
    if song.artist.nil?
      select_tag "song[artist_id]", options_from_collection_for_select(artists, :id, :name)
    else
      hidden_field_tag "song[artist_id]", song.artist.id
    end
  end

end
