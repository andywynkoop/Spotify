artists = [@artist]
albums = @artist.albums
songs = @artist.songs

json.partial! '/api/music/index.json.jbuilder', albums: albums, songs: songs, artists: artists