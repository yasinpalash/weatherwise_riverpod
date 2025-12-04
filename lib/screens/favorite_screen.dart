import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/internet_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  final Widget noFavorites = const Center(
    child: Text(
      'No favorite locations added yet! To add a favorite location, go to the search screen and search that location.',
      maxLines: 3,
      textAlign: TextAlign.center,
    ),
  );


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final favoriteLocations = ref.watch(favoriteProvider);
    final internetState = ref.watch(internetStatusProvider);
    return const Center(child: Text('Favorite Screen'));
  }
}
