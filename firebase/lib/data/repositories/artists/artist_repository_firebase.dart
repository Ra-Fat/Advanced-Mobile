import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';


class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = Uri.https(
    'grand-cineplex-default-rtdb.firebaseio.com',
    '/artists.json'
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if(response.statusCode == 200){
      final Map<String, dynamic> artistMap = json.decode(response.body);
      final List<Artist> artists = [];

      for(var entry in artistMap.entries){
        artists.add(ArtistDto.fromJson(entry.value, id: entry.key));
      }

      return artists;
    }else{
      throw Exception('Failed to load Artist');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final Uri artistUriById = Uri.https(
      'week-9-practice-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/artists/$id.json',
    );

    final http.Response response = await http.get(artistUriById);

    if(response.statusCode == 200){
      final Map<String, dynamic> artistMap = json.decode(response.body);

      return ArtistDto.fromJson(artistMap, id: id);
    }else{
      throw Exception('Failed to load Artist $id');
    }
  }
}