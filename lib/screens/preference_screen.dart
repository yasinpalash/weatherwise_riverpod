import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/temp_unit_provider.dart';
import '../providers/theme_provider.dart';
import '../themes/dark_mode.dart';
import '../themes/light_mode.dart';
import '../widgets/pref_tiles.dart';
import 'about_screen.dart';
class PreferenceScreen extends ConsumerWidget {
  const PreferenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final currentUnit = ref.watch(temperatureUnitProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PrefCard(
            icon: Icons.color_lens_outlined,
            title: "Theme",
            subtitle: currentTheme.brightness == Brightness.dark
                ? "Dark Theme"
                : "Light Theme",
            trailing: DropdownButton<ThemeData>(
              value: currentTheme,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(
                  value: lightMode,
                  child: const Text("Light Theme"),
                ),
                DropdownMenuItem(
                  value: darkMode,
                  child: const Text("Dark Theme"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.setTheme(value);
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          PrefCard(
            icon: Icons.thermostat,
            title: "Temperature Unit",
            subtitle: currentUnit == TemperatureUnit.celsius
                ? "Celsius"
                : "Fahrenheit",
            trailing: DropdownButton<TemperatureUnit>(
              value: currentUnit,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: TemperatureUnit.celsius,
                  child: Text("Celsius"),
                ),
                DropdownMenuItem(
                  value: TemperatureUnit.fahrenheit,
                  child: Text("Fahrenheit"),
                ),
              ],
              onChanged: (unit) {
                if (unit != null) {
                  ref.read(temperatureUnitProvider.notifier).setUnit(unit);
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          PrefCard(
            icon: Icons.info_outline_rounded,
            title: "About",
            subtitle: "About Weather Wise",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreenAnimated()),
              );
            },
          ),

        ],
      ),
    );
  }
}
