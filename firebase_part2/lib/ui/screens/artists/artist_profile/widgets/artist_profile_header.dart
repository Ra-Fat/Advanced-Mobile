import 'package:firebase_part2/model/artist/artist.dart';
import 'package:firebase_part2/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class ArtistProfileHeader extends StatelessWidget {
  final Artist artist;
  const ArtistProfileHeader({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              artist.imageUrl.toString(),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(artist.name, style: AppTextStyles.heading),
          Text(
            artist.genre,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
      
    );
  }
}