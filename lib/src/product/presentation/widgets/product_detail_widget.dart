import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:group_button/group_button.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  void _openBottonSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.darkThemeDarkNavBarColor,
      builder: (context) => Container(height: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RatingBar.readOnly(
              isHalfAllowed: true,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              emptyColor: MyColors.lightThemeSecondaryTextColor,
              filledColor: Colors.yellowAccent,
              initialRating: widget.product.rating,
              halfFilledColor: Colors.yellow,
              halfFilledIcon: Icons.star_half,
              size: 14,
            ),
            Text(
              "(${widget.product.rating})",
              style: TextStyles.paragraphSubTextRegular.grey,
            ),
          ],
        ),
        Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.paragraphSubTextRegular.grey,
          TextSpan(
            text: "reviews ",
            children: [TextSpan(text: "(${widget.product.reviews.length})")],
          ),
        ),
        Text(
          "\$${widget.product.price}",
          style: TextStyles.headingMedium1.adaptiveColor(context),
        ),
        Text(widget.product.name, style: TextStyles.paragraphRegular.grey),
        Gap(10),
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: MyColors.lightThemeSecondaryTextColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GroupButton(
            options: GroupButtonOptions(
              buttonHeight: 20,
              buttonWidth: 20,
              borderRadius: BorderRadius.circular(50),
            ),
            buttons: widget.product.colors,
            buttonBuilder: (selected, color, context) {
              return Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: color.toColor,
                  shape: BoxShape.circle,
                  border: selected
                      ? Border.all(
                          color: MyColors.darkThemeDarkNavBarColor,
                          width: 2,
                        )
                      : null,
                ),
              );
            },
          ),
        ),

        Gap(20),
        GroupButton(
          options: GroupButtonOptions(
            buttonHeight: 30,
            buttonWidth: 30,
            borderRadius: BorderRadius.circular(50),
            unselectedTextStyle: TextStyles.paragraphSubTextRegular.grey,
            selectedTextStyle: TextStyles.paragraphSubTextRegular.white,
            selectedBorderColor: MyColors.lightThemePrimaryColor,
            unselectedBorderColor: MyColors.lightThemeStockColor,
            selectedColor: MyColors.lightThemePrimaryColor,
            unselectedColor: Colors.transparent,
          ),
          buttons: widget.product.sizes,
        ),
        Gap(20),
        Text(
          "Description",
          style: TextStyles.headingMedium4.adaptiveColor(context),
        ),
        Gap(10),
        SelectableText(
          widget.product.description,
          style: TextStyles.paragraphSubTextRegular2.grey,
        ),
        Gap(20),
        Divider(),
        Gap(20),
        ListTile(
          onTap: _openBottonSheet,
          title: Text(
            "Reviews (${widget.product.reviews.length})",
            style: TextStyles.headingMedium4.adaptiveColor(context),
          ),
          trailing: Icon(CupertinoIcons.forward),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
