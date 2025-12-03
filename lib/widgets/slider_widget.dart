import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../utils/format_temp.dart';
import '../widgets/error_widget.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';

class SliderWidget extends ConsumerWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);
    return weather.when(
      data: (weather) {
        return _buildSliderWidget(context, weather, ref);
      },
      error: (err, st) {
        return const ShowErrorToUser();
      },
      loading: () {
        return _buildSliderWidget(context, null, ref, isLoading: true);
      },
    );
  }

  Widget _buildSliderWidget(
      BuildContext context, WeatherData? weather, WidgetRef ref,
      {bool isLoading = false}) {
    final humidity = weather?.current?.humidity?.toDouble() ?? 0.0;
    final feelsLike = weather != null
        ? getFormattedTemperature(ref, weather.current!.feelsLike!.toInt(),
            showUnit: false)
        : '-';
    final uvi = weather?.current?.uvi?.toString() ?? '-';
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.water_drop_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Comfort Level',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: humidity,
              appearance: CircularSliderAppearance(
                spinnerMode: false,
                size: 160,
                startAngle: 150,
                angleRange: 240,
                customColors: CustomSliderColors(
                  hideShadow: true,
                  trackColor: Theme.of(context).colorScheme.tertiary,
                  progressBarColors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  gradientStartAngle: 0,
                  gradientEndAngle: 180,
                  dotColor: Theme.of(context).colorScheme.primary,
                ),
                customWidths: CustomSliderWidths(
                  handlerSize: 8,
                  trackWidth: 8,
                  progressBarWidth: 8,
                  shadowWidth: 0,
                ),
                infoProperties: InfoProperties(
                  bottomLabelText: 'Humidity',
                  mainLabelStyle: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  bottomLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                    height: 1.5,
                  ),
                  modifier: (double value) {
                    return '${value.toInt()}%';
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  context,
                  icon: Icons.thermostat_rounded,
                  label: 'Feels Like',
                  value: '$feelsLike°',
                  color: Colors.orangeAccent,
                ),
                Container(
                    width: 1,
                    height: 30,
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.2)),
                _buildInfoItem(
                  context,
                  icon: Icons.wb_sunny_rounded,
                  label: 'UV Index',
                  value: uvi,
                  color: Colors.amber,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context,
      {required IconData icon,
      required String label,
      required String value,
      required Color color}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.8),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
