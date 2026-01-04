import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Category Detail or Filter Products
        print("Selected category: ${category.name}");
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: CoreUtils.adaptiveColor(
              context,
              lightModeColor: MyColors.lightThemeStockColor,
              darkModeColor: MyColors.darkThemeDarkNavBarColor,
            ),
            child: ClipOval(
              child: Image.network(
                category.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.white),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.category_outlined, color: Colors.grey),
              ),
            ),
          ),
          const Gap(2),
          Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.paragraphSubTextRegular.adaptiveColor(context),
          ),
        ],
      ),
    );
  }
}
