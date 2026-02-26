import 'package:provider/provider.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_remote.dart';
import 'main_common.dart';

List<Provider> get providersRemote {
  return [Provider<SongRepository>(create: (context) => SongRepositoryRemote())];
}

void main() {
  mainCommon(providersRemote);
}
