import '../../model/artist/artist.dart';

class ArtistDto {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String imageKey = 'imageUrl';
  static const String genreKey = 'genre';


  static Artist fromJson(Map<String , dynamic> json, {required String id}){
    assert(json[nameKey] is String);
    assert(json[imageKey] is String);
    assert(json[genreKey] is String);

    return Artist(
      id: id, 
      name: json[nameKey], 
      imageUrl: Uri.parse(json[imageKey]),
      genre: json[genreKey]
    );
  }

  Map<String, dynamic> toJson(Artist artist){
    return {
      idKey: artist.id,
      nameKey: artist.name,
      imageKey: artist.imageUrl,
      genreKey: artist.genre
    };
  }
}