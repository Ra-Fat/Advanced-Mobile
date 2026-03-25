import 'package:firebase/data/repositories/artists/artist_repository.dart';
import 'package:firebase/ui/screens/artists/view_model/artists_view_model.dart';
import 'package:firebase/ui/screens/artists/widget/artists_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistsViewModel(
        artistRepository: context.read<ArtistRepository>()
      ),
      child: ArtistsContent(),
    );
  }
}

