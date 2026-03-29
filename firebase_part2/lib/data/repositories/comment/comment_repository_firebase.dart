import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/comment/comment.dart';
import '../../dtos/comment_dto.dart';
import 'comment_repository.dart';

class CommentRepositoryFirebase implements CommentRepository {

  final Uri commentsUri = Uri.https(
    'grand-cineplex-default-rtdb.firebaseio.com',
    '/comments.json',
  );

  List<Comment>? _cachedComments;

  @override
  Future<List<Comment>> fetchArtistComments(
    String artistId, {
    bool forceFetch = false,
  }) async {

    if (!forceFetch && _cachedComments != null) {
      return _cachedComments!
          .where((c) => c.artistId == artistId)
          .toList();
    }

    final http.Response response = await http.get(commentsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load comments');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> data = json.decode(response.body);

    final List<Comment> allComments = [];

    for (final entry in data.entries) {
      allComments.add(CommentDto.fromJson(entry.key, entry.value));
    }

    _cachedComments = allComments;

    return allComments
        .where((c) => c.artistId == artistId)
        .toList();
  }

  @override
  Future<Comment> addComment(Comment comment) async {

    final http.Response response = await http.post(
      commentsUri,
      body: json.encode(CommentDto().toJson(comment)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add comment');
    }

    final String generatedId = json.decode(response.body)['name'];

    _cachedComments = null;

    final int createdAt = DateTime.now().millisecondsSinceEpoch;

    return Comment(
      id: generatedId,
      artistId: comment.artistId,
      message: comment.message,
      authorName: comment.authorName,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}