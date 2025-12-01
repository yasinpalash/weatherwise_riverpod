import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../utils/format_temp.dart';
import '../utils/get_formatted_datetime.dart';
import 'error_widget.dart';

class DailyWidget extends ConsumerWidget {
  const DailyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return weatherAsync.when(
      data: (weather) => _buildDailyList(context, ref, weather!, false),
      error: (err, st) => const ShowErrorToUser(),
      loading: () => _buildDailyList(context, ref, null, true),
    );
  }

  Widget _buildDailyList(BuildContext context, WidgetRef ref,
      WeatherData? weather, bool isLoading) {
    final dailyCount = isLoading ? 7 : weather?.daily?.length ?? 0;

    return SizedBox(
      height: 260,
      child: Skeletonizer(
        enabled: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Text(
                'Next 7 Days',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: dailyCount,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  if (isLoading) {
                    return const _DailyCardSkeleton();
                  }
                  final day = weather!.daily![index];
                  final date = getFormattedDateTime(day.dt!);
                  final icon = day.weather![0].icon;
                  final maxTemp =
                      getFormattedTemperature(ref, day.temp!.max!.toInt());
                  final minTemp =
                      getFormattedTemperature(ref, day.temp!.min!.toInt());

                  return _DailyCard(
                    date: date,
                    icon: icon.toString(),
                    maxTemp: maxTemp,
                    minTemp: minTemp,
                    humidity: day.humidity!,
                    windSpeed: day.windSpeed!,
                    isCurrent: index == 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyCard extends StatelessWidget {
  final DateTime date;
  final String icon;
  final String maxTemp;
  final String minTemp;
  final int humidity;
  final double windSpeed;
  final bool isCurrent;

  const _DailyCard({
    required this.date,
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.windSpeed,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textColor = isCurrent ? Colors.white : colorScheme.onSurface;
    final secondaryTextColor =
        isCurrent ? Colors.white70 : colorScheme.onSurfaceVariant;

    return Container(
      width: 120,
      decoration: BoxDecoration(
        gradient: isCurrent
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.tertiary,
                ],
              )
            : null,
        color: isCurrent ? null : colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: isCurrent
            ? null
            : Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
        boxShadow: [
          if (isCurrent)
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          else
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Column(
              children: [
                Text(
                  DateFormat('EEEE').format(date),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  DateFormat('MMM d').format(date),
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Container(
              decoration: isCurrent
                  ? null
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.surface,
                    ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/weather/$icon.png',
                height: 45,
                width: 45,
              ),
            ),
            Column(
              children: [
                Text(
                  maxTemp,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                Text(
                  minTemp,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isCurrent
                    ? Colors.white.withValues(alpha: 0.2)
                    : colorScheme.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DetailItem(
                    icon: Icons.water_drop_outlined,
                    value: '$humidity%',
                    color: textColor,
                  ),
                  _DetailItem(
                    icon: Icons.air,
                    value: '${windSpeed.round()}',
                    color: textColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _DetailItem(
      {required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 11, color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _DailyCardSkeleton extends StatelessWidget {
  const _DailyCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Bone.text(width: 60),
          Bone.text(width: 40, fontSize: 10),
          Bone.circle(size: 45),
          Bone.text(width: 50, fontSize: 20),
          Bone.text(width: 80, fontSize: 12),
        ],
      ),
    );
  }
}
