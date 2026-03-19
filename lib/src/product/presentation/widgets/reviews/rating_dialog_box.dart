import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class RatingDialogBox extends StatelessWidget {
  const RatingDialogBox({super.key, required this.onSelected});

  final void Function(int rating) onSelected;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: const BoxConstraints(maxHeight: 240, minWidth: 300),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CoreUtils.adaptiveColor(
            context,
            lightModeColor: MyColors.lightThemeStockColor,
            darkModeColor: MyColors.darkThemeDarkNavBarColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
            const Gap(30),
            RatingBar(
              alignment: Alignment.center,
              filledIcon: HugeIconsSolid.star,
              emptyIcon: HugeIconsStroke.star,
              onRatingChanged: (s) {},
            ),
            const Gap(20),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RoundedButton(text: "Rate", height: 36),
            ),
          ],
        ),
      ),
    );
  }
}
