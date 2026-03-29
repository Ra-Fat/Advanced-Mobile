import 'package:firebase_part2/ui/screens/artists/artist_profile/artist_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import '../../../../model/artist/artist.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/artist_tile.dart';
import '../view_model/artists_view_model.dart';

class ArtistsContent extends StatelessWidget {
  ArtistsContent({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    ArtistsViewModel mv = context.watch<ArtistsViewModel>();

    AsyncValue<List<Artist>> asyncValue = mv.artistsValue;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = RefreshIndicator(
          onRefresh: mv.refresh,
          key: _refreshIndicatorKey,
          backgroundColor: Colors.blue,
          color: Colors.white,
          child: ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) => ArtistTile(
              artist: artists[index],
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ArtistProfileScreen(artist: artists[index]))),
            ),
          ),
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _refreshIndicatorKey.currentState?.show();
            },
            icon: Icon(Icons.refresh),
          ),
          const SizedBox(height: 16),
          Text('Artist', style: AppTextStyles.heading),
          const SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
