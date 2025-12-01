import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../utils/format_temp.dart';
import 'current_details_widget.dart';
import 'error_widget.dart';

class CurrentWidget extends ConsumerWidget {
  const CurrentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return weatherAsync.when(
      data: (weather) => _buildBody(context, weather, false, ref),
      error: (err, st) => const ShowErrorToUser(),
      loading: () => _buildBody(context, null, true, ref),
    );
  }

  Widget _buildBody(BuildContext context, WeatherData? weather, bool isLoading,
      WidgetRef ref) {
    final current = weather?.current;
    final theme = Theme.of(context);
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: current != null
                      ? Image.asset(
                          'assets/weather/${current.weather![0].icon}.png',
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        current != null
                            ? DateFormat('EEE, MMM d').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    current.dt! * 1000))
                            : 'Loading...',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            current != null
                                ? getFormattedTemperature(
                                    ref, current.temp!.toInt())
                                : '--',
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                current != null
                                    ? current.weather![0].description!
                                    : '',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                current != null
                                    ? 'Feels ${current.feelsLike?.round()}°'
                                    : '',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3)),
            CurrentDetailsWidget(currentData: current),
          ],
        ),
      ),
    );
  }
}
