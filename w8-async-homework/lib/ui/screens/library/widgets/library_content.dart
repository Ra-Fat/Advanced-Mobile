import 'package:flutter/material.dart';
import 'package:lessontest/model/songs/song.dart';
import 'package:lessontest/ui/utils/request_state.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();
    RequestValue<List<Song>> requestValue = mv.songsState;

    switch (requestValue.status) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.error:
        return Center(child: Text('Error fetching songs.'));

      case RequestState.success:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text("Library", style: AppTextStyles.heading),
              SizedBox(height: 50),

              Expanded(
                child: ListView.builder(
                  itemCount: mv.songs.length,
                  itemBuilder: (context, index) => SongTile(
                    song: mv.songs[index],
                    isPlaying: mv.isSongPlaying(mv.songs[index]),
                    onTap: () {
                      mv.start(mv.songs[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}
