import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/current_weather.dart';

class CurrentDetailsWidget extends ConsumerWidget {
  final Current? currentData;

  const CurrentDetailsWidget({super.key, required this.currentData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (currentData == null) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGridItem(context,
                label: "Wind",
                value: "${currentData!.windSpeed} m/s",
                icon: Icons.air,
                color: Colors.blueAccent),
            _buildGridItem(context,
                label: "Humidity",
                value: "${currentData!.humidity}%",
                icon: Icons.water_drop_outlined,
                color: Colors.lightBlue),
            _buildGridItem(context,
                label: "UV Index",
                value: "${currentData!.uvi}",
                icon: Icons.wb_sunny_outlined,
                color: Colors.orangeAccent),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGridItem(context,
                label: "Visibility",
                value:
                    "${(currentData!.visibility! / 1000).toStringAsFixed(1)} km",
                icon: Icons.remove_red_eye_outlined,
                color: Colors.teal),
            _buildGridItem(context,
                label: "Pressure",
                value: "${currentData!.pressure} hPa",
                icon: Icons.speed,
                color: Colors.purpleAccent),
            _buildGridItem(context,
                label: "Sunset",
                value: _formatTime(currentData!.sunset!),
                icon: Icons.nights_stay_outlined,
                color: Colors.indigoAccent),
          ],
        )
      ],
    );
  }

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('h:mm a').format(date);
  }

  Widget _buildGridItem(BuildContext context,
      {required String label,
      required String value,
      required IconData icon,
      required Color color}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
