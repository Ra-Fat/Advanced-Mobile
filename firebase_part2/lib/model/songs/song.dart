class Song {
  final String id;
  final String title;
  final String artistId;
  final int like;
  final Duration duration;
  final Uri imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    required this.duration,
    required this.like,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist id: $artistId, like $like , duration: $duration)';
  }
}
