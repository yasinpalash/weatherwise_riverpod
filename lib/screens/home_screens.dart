import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/providers/internet_provider.dart';
import 'package:weatherwise/providers/screens_provider.dart';
import '../widgets/custom_navigation.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = ref.watch(screenProvider);
    final currentScreenIndex = ref.watch(screenIndexProvider);
    final hasData=ref.watch(hasDataProvider);
    if(hasData){
      return Scaffold(
        body: screens[currentScreenIndex],
        bottomNavigationBar: const CustomNavigation(),
      );
    } else{

    }
  }
}
