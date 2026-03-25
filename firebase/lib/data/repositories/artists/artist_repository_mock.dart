import '../../../model/artist/artist.dart';
import 'artist_repository.dart';

class ArtistRepositoryMock implements ArtistRepository {

  final List<Artist> _mockArtists = [
    Artist(
      id: '1',
      name: 'The Weekend',
      imageUrl: Uri.parse('https://example.com/theweekend.jpg'),
      genre: 'Pop',
    ),
    Artist(
      id: '2',
      name: 'Drake',
      imageUrl: Uri.parse('https://example.com/drake.jpg'),
      genre: 'Hip Hop',
    ),
    Artist(
      id: '3',
      name: 'Ed Sheeran',
      imageUrl: Uri.parse('https://example.com/ed.jpg'),
      genre: 'Acoustic',
    ),
    Artist(
      id: '4',
      name: 'Billie Eilish',
      imageUrl: Uri.parse('https://example.com/billie.jpg'),
      genre: 'Alternative',
    ),
  ];
  
  @override
  Future<List<Artist>> fetchArtists() async {
    return Future.delayed(const Duration(seconds: 1), () => _mockArtists);
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return Future.delayed(const Duration(seconds: 1), (){
      return _mockArtists.firstWhere(
        (artist) => artist.id == id,
        orElse: () => throw Exception("No Artist with id $id"),
      );
    });
  }
}
