import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferenceScreen extends ConsumerWidget {
  const PreferenceScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Center(
        child: Text('Preference Settings Here'),
      ),
    );
  }
}
