import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../providers/screens_provider.dart';

class CustomNavigation extends ConsumerWidget {
  const CustomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreenIndex = ref.watch(screenIndexProvider);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 25),
        child: GNav(
          selectedIndex: currentScreenIndex,
          gap: 6,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          tabBorderRadius: 16,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 350),
          backgroundColor: Colors.transparent,
          tabBackgroundColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          activeColor: Theme.of(context).colorScheme.primary,
          iconSize: 24,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
          onTabChange: (index) {
            ref.read(screenIndexProvider.notifier).state = index;
          },
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorites',
            ),
            GButton(
              icon: Icons.menu,
              text: 'Preferences',
            ),
          ],
        ),
      ),
    );
  }
}
