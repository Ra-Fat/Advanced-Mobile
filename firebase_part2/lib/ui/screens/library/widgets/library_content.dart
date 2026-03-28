import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../view_model/library_item_data.dart';
import 'library_item_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  LibraryContent({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<LibraryItemData>> asyncValue = mv.data;

    Widget content;
    switch (asyncValue.state) {
      
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(child: Text('error = ${asyncValue.error!}', style: TextStyle(color: Colors.red),));
        break;

      case AsyncValueState.success:
        List<LibraryItemData> data = asyncValue.data!;
        content = RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () => mv.refresh(),
          backgroundColor: Colors.blue,
          strokeWidth: 4.0,
          color: Colors.white,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) => LibraryItemTile(
            data: data[index],
            isPlaying: mv.isSongPlaying(data[index].song),
            onTap: () {
              mv.start(data[index].song);
            },
            onLikeTap: (){
              mv.likeSong(data[index].song.id);
            }
          ),
          ), 
        );
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
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
          Expanded(child: content),
        ],
      ),
    );
  }
}
