import 'package:flutter/material.dart';

class AboutScreenAnimated extends StatefulWidget {
  const AboutScreenAnimated({super.key});

  @override
  State<AboutScreenAnimated> createState() => _AboutScreenAnimatedState();
}

class _AboutScreenAnimatedState extends State<AboutScreenAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Interval _stagger(int index, {int max = 6}) {
    final start = (index * 0.08).clamp(0.0, 0.8);
    final end = (start + 0.45).clamp(0.0, 1.0);
    return Interval(start, end, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final features = <Map<String, dynamic>>[
      {
        'icon': Icons.thermostat_auto,
        'title': 'Accurate Weather Data',
        'subtitle':
            'Real-time temperature, humidity, wind speed and daily forecasts.',
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Location-Based Forecasts',
        'subtitle': 'Get weather for your current or any searched city.',
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Favorites',
        'subtitle': 'Save your favorite places for quick checks.',
      },
      {
        'icon': Icons.offline_bolt_outlined,
        'title': 'Offline Mode',
        'subtitle': 'Previously loaded data available without internet.',
      },
      {
        'icon': Icons.settings_outlined,
        'title': 'Customizable Preferences',
        'subtitle': 'Toggle units, themes and update frequency.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Weather Wise'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSection(
              controller: _ctrl,
              interval: _stagger(0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colorScheme.primary, colorScheme.tertiary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.cloud,
                          size: 32,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weather Wise',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Your intelligent companion for accurate and real-time weather insights.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSection(
              controller: _ctrl,
              interval: _stagger(1),
              child: Text(
                'Key Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 12),
            for (var i = 0; i < features.length; i++) ...[
              AnimatedSection(
                controller: _ctrl,
                interval: _stagger(2 + i, max: 2 + features.length),
                child: FeatureCard(
                  icon: features[i]['icon'],
                  title: features[i]['title'],
                  subtitle: features[i]['subtitle'],
                ),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 18),
            AnimatedSection(
              controller: _ctrl,
              interval: _stagger(2 + features.length),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Powered By',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const InfoCard(
                    title: 'OpenWeatherMap API',
                    description:
                        'Weather Wise retrieves accurate global weather data using the OpenWeatherMap API.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AnimatedSection(
              controller: _ctrl,
              interval: _stagger(3 + features.length),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const InfoCard(
                    title: 'Yasin Mia Palash',
                    description:
                        'Designed and crafted to deliver a clean, modern and reliable weather experience. If you like this app, support the developer!',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            AnimatedSection(
              controller: _ctrl,
              interval: const Interval(0.85, 1.0, curve: Curves.easeOut),
              animateScale: true,
              child: Center(
                child: Text(
                  '© 2025 Weather Wise',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class AnimatedSection extends StatelessWidget {
  final Widget child;
  final AnimationController controller;
  final Interval interval;
  final bool animateScale;

  const AnimatedSection({
    super.key,
    required this.child,
    required this.controller,
    required this.interval,
    this.animateScale = false,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(parent: controller, curve: interval);

    final offsetTween =
        Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero);
    final scaleTween = Tween<double>(begin: 0.98, end: 1.0);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetTween.animate(animation),
        child: animateScale
            ? ScaleTransition(
                scale: scaleTween.animate(animation), child: child)
            : child,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              )),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
