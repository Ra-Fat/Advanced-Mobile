abstract class UserHistoryRepository {
  
  // get recent id
  List<String> fetchRecentSongIds();

  // add song id 
  void addSongId(String id);
}
