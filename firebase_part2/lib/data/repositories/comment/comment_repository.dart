import '../../../model/comment/comment.dart';

abstract class CommentRepository {

  Future<List<Comment>> fetchArtistComments(
    String artistId, {
    bool forceFetch = false,
  });

  Future<Comment> addComment(Comment comment);
}