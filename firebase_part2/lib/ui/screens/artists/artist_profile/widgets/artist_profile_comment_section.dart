import 'package:firebase_part2/ui/screens/artists/artist_profile/widgets/comment_tile.dart';
import 'package:firebase_part2/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import '../view_model/artist_profile_view_model.dart';

class ArtistProfileCommentSection extends StatelessWidget {
  final ArtistProfileViewModel mv;
  const ArtistProfileCommentSection({super.key, required this.mv});

  @override
  Widget build(BuildContext context) {
    switch (mv.commentsValue.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());

      case AsyncValueState.error:
        return Center(
          child: Text(
            'Error: ${mv.commentsValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );

      case AsyncValueState.success:
        final comments = mv.commentsValue.data!;

        if (comments.isEmpty) {
          return const Center(child: Text('No comments yet.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) =>
              CommentTile(comment: comments[index]),
        );
    }
  }
}
