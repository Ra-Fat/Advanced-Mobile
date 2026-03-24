import '../../../model/songs/song.dart';
import 'song_repository.dart';

class SongRepositoryMock implements SongRepository {
  final List<Song> _songs = [
    Song(
      id: 's1',
      title: 'Mock Song 1',
      artistId: 'a1',
      duration: const Duration(minutes: 2, seconds: 50),
      imageUrl: Uri.parse('https://example.com/song1.jpg'),
    ),
    Song(
      id: 's2',
      title: 'Mock Song 2',
      artistId: 'a1',
      duration: const Duration(minutes: 3, seconds: 20),
      imageUrl: Uri.parse('https://example.com/song2.jpg'),
    ),
    Song(
      id: 's3',
      title: 'Mock Song 3',
      artistId: 'a2',
      duration: const Duration(minutes: 3, seconds: 20),
      imageUrl: Uri.parse('https://example.com/song3.jpg'),
    ),
    Song(
      id: 's4',
      title: 'Mock Song 4',
      artistId: 'a2',
      duration: const Duration(minutes: 3, seconds: 20),
      imageUrl: Uri.parse('https://example.com/song4.jpg'),
    ),
    Song(
      id: 's5',
      title: 'Mock Song 5',
      artistId: 'a3',
      duration: const Duration(minutes: 3, seconds: 20),
      imageUrl: Uri.parse('https://example.com/song5.jpg'),
    ),
  ];

  @override
  Future<List<Song>> fetchSongs() async {
    return Future.delayed(const Duration(seconds: 1), () => _songs);
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return _songs.firstWhere(
        (song) => song.id == id,
        orElse: () => throw Exception("No song with id $id"),
      );
    });
  }
}