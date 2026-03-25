import 'package:firebase/model/song_with_artist/song_with_artist.dart';
import 'package:firebase/service/song_with_artist_service.dart';
import 'package:flutter/material.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongWithArtistService songWithArtistService;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songWithArtistService, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      final songs = await songWithArtistService.fetchSongWithArtist();
      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
