import 'package:flutter/material.dart';
import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';
import 'library_item_data.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  final PlayerState playerState;

  AsyncValue<List<LibraryItemData>> data = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
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


  Future<void> fetchSong({bool forceFetch = false}) async {

    if (!forceFetch && data.state == AsyncValueState.success) return;
    
    // 1- Loading state
    data = AsyncValue.loading();
    notifyListeners();

    try {
      // 1- Fetch songs
      List<Song> songs = await songRepository.fetchSongs(forceFetch: forceFetch);

      // 2- Fethc artist
      List<Artist> artists = await artistRepository.fetchArtists(forceFetch: forceFetch);

      // 3- Create the mapping artistid-> artist
      Map<String, Artist> mapArtist = {};
      for (Artist artist in artists) {
        mapArtist[artist.id] = artist;
      }

      List<LibraryItemData> data = songs
          .map(
            (song) =>
                LibraryItemData(song: song, artist: mapArtist[song.artistId]!),
          )
          .toList();

      this.data = AsyncValue.success(data);

    } catch (e) {
      // 3- Fetch is unsucessfull
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();

  Future<void> likeSong(String songId) async{
    
    if(data.state != AsyncValueState.success || data.data == null) return;

    final List<LibraryItemData> currentItem = List.from(data.data!);

    final int index = currentItem.indexWhere((item)=> item.song.id == songId);
    if(index == -1) return;

    try{
      
      final Song updateSong = await songRepository.likeSong(songId);

      final LibraryItemData oldItem = currentItem[index];
      
      currentItem[index] = LibraryItemData(
        song: updateSong, 
        artist: oldItem.artist
      );

      data = AsyncValue.success(currentItem);
      notifyListeners();
    }catch(err){
      data = AsyncValue.error(err);
      notifyListeners();
    }
  } 

  Future<void> refresh() async {
    await fetchSong(forceFetch: true);
  }

}
