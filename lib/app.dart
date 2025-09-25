import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/providers/theme_provider.dart';
import 'package:weatherwise/screens/home_screens.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Weather Wise',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
