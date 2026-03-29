import 'package:firebase_part2/model/songs/song.dart';
import 'package:firebase_part2/ui/screens/library/view_model/library_item_data.dart';
import 'package:firebase_part2/ui/screens/library/widgets/library_item_tile.dart';
import 'package:firebase_part2/ui/states/player_state.dart';
import 'package:firebase_part2/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/artist_profile_view_model.dart';

class ArtistProfileSongSection extends StatelessWidget {
  final ArtistProfileViewModel mv;
  const ArtistProfileSongSection({super.key, required this.mv});

  @override
  Widget build(BuildContext context) {

    switch (mv.songsValue.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());

      case AsyncValueState.error:
        return Center(
          child: Text(
            'Error: ${mv.songsValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );

      case AsyncValueState.success:
        final List<Song> songs = mv.songsValue.data!;

        if (songs.isEmpty) {
          return const Center(child: Text('No songs yet.'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: songs.length,
          itemBuilder: (context, index) => LibraryItemTile(
            data: LibraryItemData(song: songs[index], artist: mv.artist),
            isPlaying:
                context.watch<PlayerState>().currentSong?.id == songs[index].id,
            onTap: () => context.read<PlayerState>().start(songs[index]),
            onLikeTap: () => mv.likeSong(songs[index].id),
          ),
        );
    }
  }
}