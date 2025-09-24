import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../providers/screens_provider.dart';

class CustomNavigation extends ConsumerWidget {
  const CustomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreenIndex = ref.watch(screenIndexProvider);
    return GNav(
      selectedIndex: currentScreenIndex ,


        tabs: []);
  }
}
