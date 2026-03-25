import 'package:firebase/model/artist/artist.dart';
import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.artist,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final Artist artist;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(song.imageUrl.toString()),
          ),
          title: Text(song.title),
          subtitle: Text('${song.durationInMinutes}    ${artist.name} - ${artist.genre}'),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
