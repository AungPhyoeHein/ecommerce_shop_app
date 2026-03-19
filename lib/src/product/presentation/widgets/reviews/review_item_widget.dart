import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget(this.review, {super.key});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: const CircleAvatar(radius: 20, backgroundColor: Colors.white),
      title: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.readOnly(
              filledIcon: HugeIconsSolid.star,
              emptyIcon: HugeIconsStroke.star,
              initialRating: review.rating.toDouble(),
              size: 16,
            ),
            Text(
              review.comment.toString(),
              style: TextStyles.paragraphSubTextRegular.adaptiveColor(context),
            ),
            const Gap(6),
            Text(
              GetTimeAgo.parse(review.createdAt!),
              style: TextStyles.paragraphSubTextRegular.grey,
            ),
          ],
        ),
      ),
      minTileHeight: 50,
      trailing: const SizedBox(width: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    );
  }
}
