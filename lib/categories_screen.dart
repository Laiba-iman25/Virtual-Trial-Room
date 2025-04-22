import 'package:flutter/material.dart';
import 'size_screen.dart'; // Import size screen

class ClothesScreen extends StatelessWidget {
  final String category;
  const ClothesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final clothes = {
      'Dresses': ['assets/clothes/dress1.png', 'assets/clothes/dress2.png'],
      'Shirts': ['assets/clothes/shirt1.png', 'assets/clothes/shirt2.png'],
      'Pants': ['assets/clothes/pants1.png', 'assets/clothes/pants2.png'],
      'Skirts': ['assets/clothes/skirt1.png', 'assets/clothes/skirt2.png'],
    };

    return Scaffold(
      appBar: AppBar(title: Text('$category Collection')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16,
        ),
        itemCount: clothes[category]!.length,
        itemBuilder: (context, index) {
          final cloth = clothes[category]![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SizeScreen(cloth: cloth)),
              );
            },
            child: Image.asset(cloth, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
