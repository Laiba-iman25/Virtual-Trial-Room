import 'package:flutter/material.dart';
import 'camera_screen.dart'; // Import camera screen

class SizeScreen extends StatelessWidget {
  final String cloth;
  const SizeScreen({super.key, required this.cloth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Size")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Choose Your Size", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['S', 'M', 'L'].map((size) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraScreen(cloth: cloth, size: size),
                      ),
                    );
                  },
                  child: Text(size, style: const TextStyle(fontSize: 20)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
