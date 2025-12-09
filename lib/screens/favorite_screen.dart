import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_provider.dart';
import '../providers/internet_provider.dart';
import '../providers/location_provider.dart';
import '../providers/screens_provider.dart';
import '../providers/search_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/favorite_tile.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  final Widget noFavorites = const Center(
    child: Padding(
      padding: EdgeInsets.all(32.0),
      child: Text(
        'No favorite locations added yet!\n\nTo add a favorite location, go to the search screen and search for a city.',
        maxLines: 5,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteLocations = ref.watch(favoriteProvider);
    final internetState = ref.watch(internetStatusProvider);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: theme.colorScheme.onSurface,
        ),
      ),
      body: SafeArea(
        child: favoriteLocations.isEmpty
            ? noFavorites
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: favoriteLocations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final location = favoriteLocations[index];

                  return Dismissible(
                    key: ValueKey(location),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      ref
                          .read(favoriteProvider.notifier)
                          .removeFavorite(location);
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: theme.colorScheme.errorContainer,
                      ),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: theme.colorScheme.onErrorContainer,
                        size: 28,
                      ),
                    ),
                    child: FavoriteTile(
                      location: location,
                      onTap: () async {
                        if (await internetState.isConnected()) {
                          ref
                              .read(searchProvider.notifier)
                              .performSearch(location.lat, location.lon);
                          ref.refresh(locationProvider);
                          ref.read(screenIndexProvider.notifier).state = 0;
                          ref.refresh(weatherProvider);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: const Text(
                                    'Please connect to internet and try again!'),
                                backgroundColor: theme.colorScheme.error,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
