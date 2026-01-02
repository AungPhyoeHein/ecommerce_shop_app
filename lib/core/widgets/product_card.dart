import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.colors,
  });

  final String name;
  final String image;
  final String description;
  final double price;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        children: [Text(name), Text(description)],
      ),
    );
  }
}
