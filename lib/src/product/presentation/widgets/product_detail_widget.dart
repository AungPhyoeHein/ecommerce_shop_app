import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/review_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/review_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:group_button/group_button.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  void _openBottonSheet() {
    final reviewCubit = context.read<ReviewCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: CoreUtils.adaptiveColor(
        context,
        lightModeColor: MyColors.lightThemeTintStockColour,
        darkModeColor: MyColors.darkThemeDarkNavBarColor,
      ),
      builder: (modalContext) => BlocProvider.value(
        value: reviewCubit,
        child: ReviewBottomSheet(productId: widget.product.id),
      ),
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
              filledIcon: HugeIconsSolid.star,
              emptyIcon: HugeIconsStroke.star,
              emptyColor: MyColors.lightThemeSecondaryTextColor,
              filledColor: Colors.yellowAccent,
              initialRating: widget.product.rating,
              halfFilledColor: Colors.yellow,
              halfFilledIcon: HugeIconsSolid.starHalf,
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
        const Gap(10),
        Container(
          padding: const EdgeInsets.all(3),
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

        const Gap(20),
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
        const Gap(20),
        Text(
          "Description",
          style: TextStyles.headingMedium4.adaptiveColor(context),
        ),
        const Gap(10),
        SelectableText(
          widget.product.description,
          style: TextStyles.paragraphSubTextRegular2.grey,
        ),
        const Gap(20),
        const Divider(),
        const Gap(20),
        ListTile(
          onTap: _openBottonSheet,
          title: Text(
            "Reviews (${widget.product.reviews.length})",
            style: TextStyles.headingMedium4.adaptiveColor(context),
          ),
          trailing: const Icon(CupertinoIcons.forward),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
