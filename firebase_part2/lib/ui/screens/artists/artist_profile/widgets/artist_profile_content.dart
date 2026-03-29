import 'package:firebase_part2/ui/screens/artists/artist_profile/widgets/artist_profile_comment_section.dart';
import 'package:firebase_part2/ui/screens/artists/artist_profile/widgets/artist_profile_songs_section.dart';
import 'package:firebase_part2/ui/screens/artists/artist_profile/view_model/artist_profile_view_model.dart';
import 'package:firebase_part2/ui/screens/artists/artist_profile/widgets/artist_profile_header.dart';
import 'package:firebase_part2/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistProfileContent extends StatelessWidget {
  const ArtistProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistProfileViewModel mv = context.watch<ArtistProfileViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArtistProfileHeader(artist: mv.artist),
          Text('Songs', style: AppTextStyles.body),
          ArtistProfileSongSection(mv: mv),
          Text('Comments', style: AppTextStyles.body),
          ArtistProfileCommentSection(mv: mv),
        ],
      ),
    );
  }
}
