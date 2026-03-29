import 'package:firebase_part2/data/repositories/artist/artist_repository.dart';
import 'package:firebase_part2/data/repositories/comment/comment_repository.dart';
import 'package:firebase_part2/data/repositories/songs/song_repository.dart';
import 'package:firebase_part2/model/artist/artist.dart';
import 'package:firebase_part2/ui/screens/artists/artist_profile/view_model/artist_profile_view_model.dart';
import 'package:firebase_part2/ui/screens/artists/artist_profile/widgets/artist_profile_content.dart';
import 'package:firebase_part2/ui/screens/artists/artist_profile/widgets/comment_form.dart';
import 'package:firebase_part2/ui/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistProfileScreen extends StatelessWidget {
  final Artist artist;

  const ArtistProfileScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.watch<AppSettingsState>().theme.backgroundColor;

    return ChangeNotifierProvider(
      create: (context) => ArtistProfileViewModel(
        artistRepo: context.read<ArtistRepository>(), 
        songRepo: context.read<SongRepository>(), 
        commentRepo: context.read<CommentRepository>(),
        artist: artist
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(artist.name)),
        body: ArtistProfileContent(),
        backgroundColor: backgroundColor,
        bottomNavigationBar: CommentForm(),
      ),
    );
  }
}
