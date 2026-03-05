import 'package:flutter/foundation.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/user_history/user_history_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final UserHistoryRepository _userHistoryRepository;
  final PlayerState _playerState;


  HomeViewModel({
    required SongRepository songRepository,
    required UserHistoryRepository userHistoryRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _userHistoryRepository = userHistoryRepository,
        _playerState = playerState {
    _playerState.addListener(_onPlayerStateChanged);
    init();
  }

  List<Song> _recentSongs = [];

  List<Song> _recommendedSongs = [];

  List<Song> get recentSongs => _recentSongs;

  List<Song> get recommendedSongs => _recommendedSongs;

  Song? get currentSong => _playerState.currentSong;

  void init() {
    // fetch recent song id from history
    final recentIds = _userHistoryRepository.fetchRecentSongIds();

    _recentSongs = recentIds
        .map((id) => _songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();

    final recentIdSet = recentIds.toSet();

    // recommmend all song that not in recent
    _recommendedSongs = _songRepository
        .fetchSongs()
        .where((song) => !recentIdSet.contains(song.id))
        .toList();

    notifyListeners();
  }

  void _onPlayerStateChanged() {
    notifyListeners();
  }

  void playSong(Song song) {
    _userHistoryRepository.addSongId(song.id);
    _playerState.start(song);
    init();
  }

  void stop() {
    _playerState.stop();
  }
}
