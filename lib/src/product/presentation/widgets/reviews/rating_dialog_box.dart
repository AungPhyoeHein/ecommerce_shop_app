import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class RatingDialogBox extends StatefulWidget {
  const RatingDialogBox({super.key, required this.onSelected});

  final void Function(int rating) onSelected;

  @override
  State<RatingDialogBox> createState() => _RatingDialogBoxState();
}

class _RatingDialogBoxState extends State<RatingDialogBox> {
  double _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CoreUtils.adaptiveColor(
            context,
            lightModeColor: MyColors.lightThemeStockColor,
            darkModeColor: MyColors.darkThemeDarkNavBarColor,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MyColors.lightThemePrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                HugeIconsStroke.star,
                color: MyColors.lightThemePrimaryColor,
                size: 32,
              ),
            ),
            const Gap(16),
            Text(
              "Rate this product",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.classicAdaptiveTextColor(context),
              ),
            ),
            const Gap(24),
            RatingBar(
              alignment: Alignment.center,
              filledIcon: HugeIconsSolid.star,
              emptyIcon: HugeIconsStroke.star,
              onRatingChanged: (rating) {
                setState(() {
                  _currentRating = rating;
                });
              },
              initialRating: _currentRating,
              maxRating: 5,
              filledColor: Colors.amber,
              emptyColor: Colors.grey.shade400,
            ),
            const Gap(32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundedButton(
                text: "Rate Now",
                height: 45,
                onPressed: _currentRating > 0
                    ? () {
                        widget.onSelected(_currentRating.toInt());
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
            const Gap(8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: MyColors.adaptiveSecondaryTextColor(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
