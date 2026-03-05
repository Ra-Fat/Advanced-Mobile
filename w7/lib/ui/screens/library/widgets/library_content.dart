import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song.dart';
import '../view_model/library_view_model.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import './song_tile.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LibraryViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                Song song = viewModel.songs[index];

                return SongTile(
                  song: song,
                  isPlaying: viewModel.currentSong == song,
                  onPlay: () => viewModel.playSong(song),
                  onStop: () => viewModel.stop(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


