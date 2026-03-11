import 'package:flutter/material.dart';
import 'package:lessontest/ui/utils/request_state.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  List<Song>? _songs;

  RequestValue<List<Song>> _songsState = const RequestValue.loading();
  RequestValue<List<Song>> get songsState => _songsState;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  List<Song> get songs => _songs == null ? [] : _songs!;


  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    _songsState = const RequestValue.loading();
    notifyListeners();
    try {
      _songs = await songRepository.fetchSongs();
      _songsState = RequestValue.success(_songs);
    } catch (err) {
      _songsState = RequestValue.error(err);
    }

    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
