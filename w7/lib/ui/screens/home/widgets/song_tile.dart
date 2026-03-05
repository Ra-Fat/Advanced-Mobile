import 'package:flutter/material.dart';
import 'package:w7/model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onPlay,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: isPlaying ? null : onPlay,
      title: Text(song.title),
      trailing: isPlaying
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('playing', style: TextStyle(color: Colors.amber)),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onStop,
                  child: const Text('STOP'),
                ),
              ],
            )
          : null,
    );
  }
}