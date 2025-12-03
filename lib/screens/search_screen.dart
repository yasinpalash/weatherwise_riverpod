import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _inputController = TextEditingController();
  void _performSearch( String value){


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Search Location'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Search for a location you want to know the current weather of',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                            controller: _inputController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon:
                                  const Icon(Icons.location_on_outlined),
                              suffixIcon: _inputController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.clear,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 20,
                                      ))
                                  : null,
                              border: const OutlineInputBorder(),
                            )))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
