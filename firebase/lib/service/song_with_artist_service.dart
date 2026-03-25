import 'package:firebase/model/songs/song.dart';

import '../data/repositories/songs/song_repository.dart';
import '../data/repositories/artists/artist_repository.dart';
import '../model/artist/artist.dart';
import '../model/song_with_artist/song_with_artist.dart';

class SongWithArtistService {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  SongWithArtistService({
    required this.artistRepository,
    required this.songRepository
  });

  Future<List<SongWithArtist>> fetchSongWithArtist() async{
    final songs = await songRepository.fetchSongs();
    final artists = await artistRepository.fetchArtists();
    final List<SongWithArtist> songWithArtist = [];

    for(Song song in songs){
      Artist? matchedArtist;

      for(Artist artist in artists){
        if(artist.id == song.artistId){
          matchedArtist = artist;
          break;
        }
      }

      if(matchedArtist != null){
        songWithArtist.add(
          SongWithArtist(
            song: song,
            artist: matchedArtist
          ),
        );
      }
    }
    return songWithArtist;
  }
}