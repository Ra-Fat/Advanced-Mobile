import '../../model/comment/comment.dart';

class CommentDto {
  static const String idKey = 'id';
  static const String artistIdKey = 'artistId';
  static const String messageKey = 'message';
  static const String createdAtKey = 'createdAt';

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[artistIdKey] is String);
    assert(json[messageKey] is String);
    assert(json[createdAtKey] is String);

    return Comment(
      id: id,
      artistId: json[artistIdKey],
      message: json[messageKey],
      createdAt: DateTime.parse(json[createdAtKey]),
    );
  }

  Map<String, dynamic> toJson(Comment comment){
    return {
      idKey: comment.id,
      artistIdKey: comment.artistId,
      messageKey: comment.message,
      createdAtKey: comment.createdAt.toIso8601String(),
    };
  }
}