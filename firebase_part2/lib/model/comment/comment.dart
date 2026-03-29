class Comment {
  final String id;
  final String artistId;
  final String message;
  final String? authorName;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.artistId,
    required this.message,
    this.authorName,
    required this.createdAt
  });

  @override
  String toString() {
    return 'Comment(id: $id, artistId: $artistId, message: $message , authorName: $authorName , createdAt: $createdAt)';
  }
}
