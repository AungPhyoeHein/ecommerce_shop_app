import 'package:flutter/material.dart';

import '../res/styles/colors.dart';

class DynamicLoaderWidget extends StatelessWidget {
  const DynamicLoaderWidget({
    super.key,
    required this.originalWidget,
    required this.isLoading,
    this.loadingWidget,
  });

  final Widget originalWidget;
  final bool isLoading;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ??
          const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: MyColors.lightThemePrimaryColor,
            ),
          );
    }

    return originalWidget;
  }
}
