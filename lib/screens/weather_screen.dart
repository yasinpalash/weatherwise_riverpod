import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/widgets/current_widget.dart';

import '../widgets/location_widget.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
             SizedBox(height: 5),
             LocationWidget(),
             SizedBox(height: 10),
            CurrentWidget()

          ],
        ),
      ),
    );
  }
}
