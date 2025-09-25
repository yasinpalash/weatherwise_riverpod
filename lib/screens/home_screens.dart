import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weatherwise/providers/internet_provider.dart';
import 'package:weatherwise/providers/screens_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/custom_navigation.dart';
import 'no_internet_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = ref.watch(screenProvider);
    final currentScreenIndex = ref.watch(screenIndexProvider);
    final hasData = ref.watch(hasDataProvider);
    final onInternetStatusChange = ref.watch(internetStatusChangeProvider);
    final locationService = ref.watch(locationProvider);
    if (hasData) {
      return Scaffold(
        body: screens[currentScreenIndex],
        bottomNavigationBar: const CustomNavigation(),
      );
    } else {
      return locationService.when(
        data: (placemark) {
          return onInternetStatusChange.when(
            data: (state) {
              return state == InternetStatus.connected
                  ? Scaffold(
                      body: screens[currentScreenIndex],
                      bottomNavigationBar: const CustomNavigation(),
                    )
                  : const NoInternetScreen();
            },
            error: (err, st) {
              return const NoInternetScreen();
            },
            loading: () => Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          );
        },
        error: (err, st) {
          return const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 70.0),
                    SizedBox(height: 10.0),
                    Text(
                      'Error Occured while fetching the location. You may go to app settings and enable the location permission or Check your internet connection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      );
    }
  }
}
