import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
  'grand-cineplex-default-rtdb.firebaseio.com',
  '/songs.json',
);

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // // 1 - Send the retrieved list of songs
      final Map<String, dynamic> songMap = json.decode(response.body);
      final List<Song> songs = [];

      for(var entry in songMap.entries){
        songs.add(SongDto.fromJson(entry.value, id: entry.key));
      }
      return songs;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
