import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import 'error_widget.dart';

class CurrentWidget extends ConsumerWidget {
  const CurrentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);
    return weather.when(
        data: (weather) {
          return _buildCurrentWidget(context, weather, false, ref);
        },
        error: (err, st) {
          return const ShowErrorToUser();
        },
        loading: () {
          return _buildCurrentWidget(context, null, true, ref);
        });
  }

  _buildCurrentWidget(BuildContext context, WeatherData? weather,
      bool isLoading, WidgetRef ref) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(),
    );
  }
}
