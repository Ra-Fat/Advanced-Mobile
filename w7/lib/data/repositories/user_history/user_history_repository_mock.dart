import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {

  // store recent song id that user have played
  final List<String> _recentSongIds = [];

  @override
  List<String> fetchRecentSongIds() => List.unmodifiable(_recentSongIds);

  @override
  void addSongId(String id) {
    _recentSongIds.remove(id);
    _recentSongIds.insert(0, id);
  }
}
