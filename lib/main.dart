import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Center(
              child: Text('Hello World!'),
            ),
          ],
        ),
      ),
    );
  }
}
