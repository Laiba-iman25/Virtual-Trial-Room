import 'package:flutter/material.dart';

class TryOnScreen extends StatelessWidget {
  final String imagePath;
  final String cloth;
  const TryOnScreen({super.key, required this.imagePath, required this.cloth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Try On")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(imagePath)),
            const SizedBox(height: 20),
            Text('Cloth: $cloth', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            // You can overlay the selected cloth image here on top of the captured image
          ],
        ),
      ),
    );
  }
}
