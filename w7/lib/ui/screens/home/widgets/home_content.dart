import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './song_tile.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../home_view_model/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text('Home', style: AppTextStyles.heading),
          const SizedBox(height: 24),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // recent song show
                Text(
                  'Your recent songs',
                  style: AppTextStyles.label.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                if (homeViewModel.recentSongs.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('No Recent Song.'),
                  )
                else
                  ...homeViewModel.recentSongs.map(
                    (song) => SongTile(
                      song: song,
                      isPlaying: homeViewModel.currentSong == song,
                      onPlay: () => homeViewModel.playSong(song),
                      onStop: () => homeViewModel.stop(),
                    ),
                  ),
                const SizedBox(height: 24),
                // recommendation song show
                Text(
                  'You might also like',
                  style: AppTextStyles.label.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                if (homeViewModel.recommendedSongs.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('No recommendations.'),
                  )
                else
                  ...homeViewModel.recommendedSongs.map(
                    (song) => SongTile(
                      song: song,
                      onPlay: () => homeViewModel.playSong(song),
                      onStop: () => homeViewModel.stop(),
                      isPlaying: homeViewModel.currentSong == song,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
