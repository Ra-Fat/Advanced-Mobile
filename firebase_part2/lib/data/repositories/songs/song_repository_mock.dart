// song_repository_mock.dart

import '../../../model/songs/song.dart';
import 'song_repository.dart';

class SongRepositoryMock implements SongRepository {
  final List<Song> _songs = [  ];

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    return Future.delayed(Duration(seconds: 4), () {
      throw _songs;
    });
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    return Future.delayed(Duration(seconds: 4), () {
      return _songs.firstWhere(
        (song) => song.id == id,
        orElse: () => throw Exception("No song with id $id in the database"),
      );
    });
  }

  @override
  Future<Song> likeSong(String id) {
    return Future.delayed(Duration(milliseconds: 500), () {
      final int index = _songs.indexWhere((song) => song.id == id);
      if (index == -1) {
        throw Exception("No song with id $id");
      }
      final Song current = _songs[index];

      final Song updated = Song(
        id: current.id,
        title: current.title,
        artistId: current.artistId,
        like: current.like + 1,
        duration: current.duration,
        imageUrl: current.imageUrl
      );
      
       _songs[index] = updated;
       return updated;
    });
  }
}
