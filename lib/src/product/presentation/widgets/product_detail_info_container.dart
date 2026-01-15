import 'package:flutter/material.dart';

class ProductDetailInfoContainer extends StatelessWidget {
  const ProductDetailInfoContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 350,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
