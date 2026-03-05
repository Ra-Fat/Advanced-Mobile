import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/user_history/user_history_repository.dart';
import '../../states/player_state.dart';
import 'widgets/home_content.dart';
import 'home_view_model/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songRepository = context.read<SongRepository>();
    final userHistoryRepository = context.read<UserHistoryRepository>();
    final playerState = context.read<PlayerState>();

    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(
        songRepository: songRepository,
        userHistoryRepository: userHistoryRepository,
        playerState: playerState,
      ),
      child: const HomeContent(),
    );
  }
}
