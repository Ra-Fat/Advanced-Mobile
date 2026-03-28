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
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<Song> likeSong(String id) async {
    
    final Uri songUri = Uri.https(
      'grand-cineplex-default-rtdb.firebaseio.com',
      '/songs/$id.json',
    );

    final http.Response response = await http.get(songUri);

    if(response.statusCode == 200){
      final Map<String, dynamic> songData = json.decode(response.body);

      int currentLikes = songData['like'] ?? 0;
      songData['like'] = currentLikes + 1;

      final http.Response updateLike = await http.patch(
        songUri,
        body: json.encode({
          'like' : songData['like'],
        })
      );

      if(updateLike.statusCode == 200){
        return SongDto.fromJson(id, songData);
      }else{
        throw Exception('Failed to update like');
      }
    }else{
      throw Exception('Failed to fetch song');
    }
  }
}
