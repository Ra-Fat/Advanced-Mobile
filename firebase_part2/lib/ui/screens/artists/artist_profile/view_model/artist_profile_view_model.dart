import 'package:firebase_part2/data/repositories/artist/artist_repository.dart';
import 'package:firebase_part2/data/repositories/songs/song_repository.dart';
import 'package:firebase_part2/data/repositories/comment/comment_repository.dart';
import 'package:firebase_part2/model/artist/artist.dart';
import 'package:firebase_part2/model/comment/comment.dart';
import 'package:firebase_part2/model/songs/song.dart';
import 'package:firebase_part2/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class ArtistProfileViewModel extends ChangeNotifier {
  final ArtistRepository artistRepo;
  final SongRepository songRepo;
  final CommentRepository commentRepo;
  final Artist artist;

  ArtistProfileViewModel({
    required this.artistRepo,
    required this.songRepo,
    required this.commentRepo,
    required this.artist,
  }) {
    _fetchData();
  }

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Comment>> commentsValue = AsyncValue.loading();

  void _fetchData() async {
    await Future.wait([_fetchSongs(), _fetchComments()]);
  }

  Future<void> _fetchSongs() async {
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Song> allSongs = await songRepo.fetchSongs();
      songsValue = AsyncValue.success(
        allSongs.where((song) => song.artistId == artist.id).toList(),
      );
    } catch (err) {
      songsValue = AsyncValue.error(err);
    }

    notifyListeners();
  }

  Future<void> _fetchComments() async {
    commentsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Comment> comments =
          await commentRepo.fetchArtistComments(artist.id);

      commentsValue = AsyncValue.success(comments);
    } catch (err) {
      commentsValue = AsyncValue.error(err);
    }

    notifyListeners();
  }

  void addComment(String message) async {
    try {
      final Comment newComment = await commentRepo.addComment(
        Comment(
          id: '',
          artistId: artist.id,
          message: message,
          createdAt: DateTime.now(),
        ),
      );

      final List<Comment> currentComments = commentsValue.data ?? [];

      commentsValue = AsyncValue.success([
        ...currentComments,
        newComment,
      ]);
    } catch (err) {
      commentsValue = AsyncValue.error(err);
    }
    notifyListeners();
  }

  void likeSong(String songId) async {
    try {
      final Song updatedSong = await songRepo.likeSong(songId);

      final List<Song> currentSongs = songsValue.data!;
      final List<Song> updatedSongs = [];

      for (var song in currentSongs) {
        if (song.id == songId) {
          updatedSongs.add(updatedSong);
        } else {
          updatedSongs.add(song);
        }
      }
      songsValue = AsyncValue.success(updatedSongs);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }
}