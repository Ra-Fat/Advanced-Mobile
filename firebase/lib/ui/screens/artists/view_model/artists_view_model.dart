import 'package:firebase/data/repositories/artists/artist_repository.dart';
import 'package:firebase/model/artist/artist.dart';
import 'package:firebase/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class ArtistsViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  
  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();


  ArtistsViewModel({required this.artistRepository}){
    _init();
  }

  void _init() async{
    fetchArtist();
  }

  void fetchArtist() async{
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try{
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    }catch(err){
      artistsValue = AsyncValue.error(err);
    }
    notifyListeners();
  }
}