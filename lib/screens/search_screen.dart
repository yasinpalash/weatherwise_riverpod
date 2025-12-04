// ignore_for_file: unused_result
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../providers/area_provider.dart';
import '../providers/location_provider.dart';
import '../providers/screens_provider.dart';
import '../providers/search_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/search_suggestion_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _showResults = value.isNotEmpty;
      });
      if (value.isNotEmpty) {
        ref.refresh(areaProvider(value));
      }
    });
  }

  void _handleSelection(double lat, double lon) {
    ref.read(searchProvider.notifier).performSearch(lat, lon);
    ref.refresh(locationProvider);
    ref.refresh(weatherProvider);
    ref.read(screenIndexProvider.notifier).state = 0;
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final areaAsyncValue = _showResults
        ? ref.watch(areaProvider(_inputController.text))
        : const AsyncValue.data(null);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _inputController,
                        focusNode: _focusNode,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search city...',
                          hintStyle:
                              TextStyle(color: colorScheme.onSurfaceVariant),
                          prefixIcon:
                              Icon(Icons.search, color: colorScheme.primary),
                          suffixIcon: _inputController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: () {
                                    _inputController.clear();
                                    setState(() => _showResults = false);
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildBody(areaAsyncValue, colorScheme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
      AsyncValue<List<dynamic>?> areaState, ColorScheme colorScheme) {
    if (!_showResults) {
      return _buildIdleState(colorScheme);
    }
    return areaState.when(
      loading: () => Skeletonizer(
        enabled: true,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => const _LocationCardSkeleton(),
        ),
      ),
      error: (error, _) => _buildErrorState(error.toString(), colorScheme),
      data: (areas) {
        if (areas == null || areas.isEmpty) {
          return _buildEmptyState(colorScheme);
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: areas.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final area = areas[index];
            return LocationCard(
              city: area.name ?? 'Unknown',
              region: '${area.state ?? ''}, ${area.country ?? ''}'
                  .replaceAll(RegExp(r'^, '), ''),
              onTap: () => _handleSelection(area.lat!, area.lon!),
            );
          },
        );
      },
    );
  }

  Widget _buildIdleState(ColorScheme colorScheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_city_rounded,
            size: 80, color: colorScheme.primary.withValues(alpha: 0.2)),
        const SizedBox(height: 16),
        Text(
          "Find your city",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface),
        ),
        const SizedBox(height: 8),
        Text(
          "Enter a location to see the weather",
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 30),
        InkWell(
          onTap: () {
            ref.read(screenIndexProvider.notifier).state = 0;
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.my_location,
                    size: 20, color: colorScheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Text(
                  "Use Current Location",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded,
            size: 64, color: colorScheme.error.withValues(alpha: 0.5)),
        const SizedBox(height: 16),
        Text("No results found",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface)),
      ],
    );
  }

  Widget _buildErrorState(String error, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("Error: $error",
            textAlign: TextAlign.center,
            style: TextStyle(color: colorScheme.error)),
      ),
    );
  }
}

class _LocationCardSkeleton extends StatelessWidget {
  const _LocationCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Bone.circle(size: 44),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(width: 120),
                SizedBox(height: 8),
                Bone.text(width: 80, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
