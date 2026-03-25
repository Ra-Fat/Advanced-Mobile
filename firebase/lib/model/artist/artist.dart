class Artist {
  final String id;
  final String name;
  final Uri imageUrl;
  final String genre;

  Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.genre
  });


  @override
  String toString() {
    return 'Artist(id: $id, name: $name, genre: $genre, imageUrl: $imageUrl)';
  }
}

