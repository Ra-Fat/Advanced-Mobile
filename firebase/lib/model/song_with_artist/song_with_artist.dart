import '../artist/artist.dart';
import '../songs/song.dart';

class SongWithArtist {
  final Artist artist;
  final Song song;

  SongWithArtist({
    required this.artist,
    required this.song
  });

  @override
  String toString() {
    return 'artist: $artist, song: $song';
  }
}