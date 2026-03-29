import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = Uri.https(
    'grand-cineplex-default-rtdb.firebaseio.com',
    '/artists.json',
  );

  List<Artist>? _cachedArtistsData;

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {

    if (!forceFetch && _cachedArtistsData != null) {
      return _cachedArtistsData!;
    }

    final http.Response response = await http.get(artistsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load artists');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> data = json.decode(response.body);

    final List<Artist> result = [];

    for (final entry in data.entries) {
      result.add(ArtistDto.fromJson(entry.key, entry.value));
    }

    _cachedArtistsData = result;

    return result;
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {

  }
}