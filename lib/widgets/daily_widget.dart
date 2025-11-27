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
    final weather = ref.watch(weatherProvider);
    return weather.when(data: (weather) {
      return _buildDailyWidget(context, weather, false, ref);
    }, error: (err, st) {
      return const ShowErrorToUser();
    }, loading: () {
      return _buildDailyWidget(context, null, true, ref);
    });
  }

  Widget _buildDailyWidget(BuildContext context, WeatherData? weather,
      bool isLoading, WidgetRef ref) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .onSurfaceVariant
              .withValues(alpha: .1),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                weather != null
                    ? 'Weather forecast for this week'
                    : 'Daily data Loading...',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 12),
            weather != null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .45,
                    child: ListView.builder(
                      itemCount: weather.daily!.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                                  .withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: MediaQuery.sizeOf(context).height * .08,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    DateFormat('E').format(
                                      getFormattedDateTime(
                                          weather.daily![index].dt!),
                                    ),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/weather/${weather.daily![index].weather![0].icon}.png',
                                        height: 30,
                                      ),
                                      Text(
                                        weather.daily![index].weather![0]
                                            .description!,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${getFormattedTemperature(ref, weather.daily![index].temp!.max!.toInt(), showUnit: false)} / ${getFormattedTemperature(ref, weather.daily![index].temp!.min!.toInt(), showUnit: false)}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * .45,
                    child: const Center(
                      child: Text('Loading...'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
