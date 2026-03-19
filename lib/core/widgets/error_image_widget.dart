import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class ErrorImageWidget extends StatelessWidget {
  const ErrorImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          HugeIconsStroke.imageNotFound01,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
