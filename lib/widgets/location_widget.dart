import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weatherwise/providers/location_provider.dart';
import 'package:weatherwise/utils/get_location_name.dart';
import 'error_widget.dart';

class LocationWidget extends ConsumerStatefulWidget {
  const LocationWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends ConsumerState<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider);
    return location.when(data: (location) {
      return _buildLocationWidget(context, location, false);
    }, error: (err, st) {
      return const ShowErrorToUser();
    }, loading: () {
      return _buildLocationWidget(context, null, true);
    });
  }

  Widget _buildLocationWidget(
      BuildContext context, Placemark? location, bool isLoading) {
    final city = location != null ? getLocationName(location) : "Loading...";
    final country = location?.country ?? "Searching location...";
    final theme = Theme.of(context);
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.15),
              child: Icon(Icons.location_on_rounded,
                  size: 26, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    country,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ),
            if (!isLoading)
              IconButton(
                onPressed: () => ref.refresh(locationProvider),
                icon: const Icon(Icons.refresh_rounded, size: 22),
                tooltip: "Refresh Location",
              )
          ],
        ),
      ),
    );
  }
}
