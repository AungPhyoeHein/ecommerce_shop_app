import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/input_field.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/review_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/reviews/rating_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class ReviewCommentBox extends StatefulWidget {
  const ReviewCommentBox({super.key, required this.productId});

  final String productId;

  @override
  State<ReviewCommentBox> createState() => _ReviewCommentBoxState();
}

class _ReviewCommentBoxState extends State<ReviewCommentBox> {
  final TextEditingController _commentController = TextEditingController();
  int? _rating;

  void _setRating(int rating) {
    _rating = rating;
  }

  void openStarBox() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RatingDialogBox(onSelected: _setRating),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
          color: CoreUtils.adaptiveColor(
            context,
            lightModeColor: MyColors.lightThemeTintStockColour,
            darkModeColor: MyColors.darkThemeDarkNavBarColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Row(
            children: [
              const CircleAvatar(),
              const Gap(10),
              Expanded(
                child: InputField(
                  controller: _commentController,
                  expendable: true,
                ),
              ),
              IconButton.filled(
                onPressed: openStarBox,
                icon: const Icon(HugeIconsStroke.star),
              ),
              IconButton.filled(
                onPressed: () {
                  if (_commentController.text.trim().isEmpty) {
                    CoreUtils.showSnackBar(
                      context,
                      message: "Comment shouldn't be empty.",
                    );
                    return;
                  }
                  if (_rating == null) {
                    CoreUtils.showSnackBar(
                      context,
                      message: "You need to select rating.",
                    );
                    return;
                  }

                  context.read<ReviewCubit>().leaveReview(
                    productId: widget.productId,
                    rating: _rating!,
                    comment: _commentController.text.trim(),
                  );
                  _commentController.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(HugeIconsStroke.sent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
