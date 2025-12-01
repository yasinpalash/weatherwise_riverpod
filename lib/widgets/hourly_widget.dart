import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../models/hourly_weather.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../utils/format_temp.dart';
import '../utils/get_formatted_datetime.dart';
import 'error_widget.dart';

class HourlyWidget extends ConsumerWidget {
  const HourlyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return weatherAsync.when(
      data: (weather) => _buildHourlyList(context, ref, weather!, false),
      error: (err, st) => const ShowErrorToUser(),
      loading: () => _buildHourlyList(context, ref, null, true),
    );
  }

  Widget _buildHourlyList(BuildContext context, WidgetRef ref,
      WeatherData? weather, bool isLoading) {
    final hourlyData = (weather?.hourly != null && weather!.hourly!.length > 24)
        ? weather.hourly!.sublist(0, 24)
        : weather?.hourly ?? [];

    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text(
              'Hourly Forecast',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          SizedBox(
            height: 160,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: isLoading ? 24 : hourlyData.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  );
                }
                final item = hourlyData[index];
                final isCurrent = index == 0;
                return _HourlyCapsule(
                  item: item,
                  isCurrent: isCurrent,
                  ref: ref,
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

class _HourlyCapsule extends StatelessWidget {
  final Hourly item;
  final bool isCurrent;
  final WidgetRef ref;

  const _HourlyCapsule({
    required this.item,
    required this.isCurrent,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final popPercent = ((item.pop ?? 0) * 100).round();
    final hasRain = popPercent > 0;

    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isCurrent
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(35),
        border: isCurrent
            ? null
            : Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isCurrent
                ? "Now"
                : DateFormat('j').format(getFormattedDateTime(item.dt!)),
            style: TextStyle(
              fontSize: 13,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
              color: isCurrent
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          Column(
            children: [
              Image.asset(
                'assets/weather/${item.weather![0].icon}.png',
                width: 32,
                height: 32,
              ),
              if (hasRain) ...[
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop_rounded,
                      size: 10,
                      color: isCurrent ? Colors.lightBlueAccent : Colors.blue,
                    ),
                    Text(
                      "$popPercent%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isCurrent ? colorScheme.onPrimary : Colors.blue,
                      ),
                    ),
                  ],
                )
              ] else
                const SizedBox(height: 12),
            ],
          ),
          Text(
            getFormattedTemperature(ref, item.temp!.toInt()),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isCurrent ? colorScheme.onPrimary : colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
