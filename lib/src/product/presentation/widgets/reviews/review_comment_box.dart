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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _rating;
  bool _showRatingError = false;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
      _showRatingError = false;
    });
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
        child: Form(
          key: _formKey,
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
                    fillColor: CoreUtils.adaptiveColor(
                      context,
                      lightModeColor: MyColors.lightThemeStockColor,
                      darkModeColor: MyColors.lightThemePrimaryTextColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a comment';
                      }
                      return null;
                    },
                    hintText: "Write a comment...",
                  ),
                ),
                Gap(10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: _rating != null
                            ? Colors.amber.withOpacity(0.2)
                            : null,
                        side: _showRatingError
                            ? const BorderSide(
                                color: Colors.redAccent,
                                width: 1.5,
                              )
                            : null,
                      ),
                      onPressed: openStarBox,
                      icon: Icon(
                        _rating != null
                            ? HugeIconsStroke.star
                            : HugeIconsStroke.star,
                        color: _rating != null ? Colors.amber : null,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                IconButton.filled(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      if (_rating == null) {
                        setState(() => _showRatingError = true);
                      }
                      return;
                    }
                    if (_rating == null) {
                      setState(() => _showRatingError = true);
                      return;
                    }

                    context.read<ReviewCubit>().leaveReview(
                      productId: widget.productId,
                      rating: _rating!,
                      comment: _commentController.text.trim(),
                    );
                    _commentController.clear();
                    setState(() {
                      _rating = null;
                      _showRatingError = false;
                    });
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(HugeIconsStroke.sent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
