import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/review_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/reviews/review_comment_box.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/reviews/review_item_widget.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/reviews/review_shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({super.key, required this.productId});

  final String productId;

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getProductReviews(productId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 1,
        expand: false,
        builder: (context, scrollController) =>
            BlocConsumer<ReviewCubit, ReviewState>(
              listener: (context, state) {
                if (state is ReviewError) {
                  CoreUtils.showSnackBar(context, message: state.message);
                } else if (state is ReviewSuccess) {
                  CoreUtils.showSnackBar(
                    context,
                    message: "Added your review.",
                  );
                } else if (state is EditedReviewState) {
                  CoreUtils.showSnackBar(
                    context,
                    message: "Edited your review.",
                  );
                } else if (state is DeletedReviewState) {
                  CoreUtils.showSnackBar(
                    context,
                    message: "Removed your review.",
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const Gap(20),
                    Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(20),
                    if (state is GotReviews)
                      state.reviews.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: state.reviews.length,
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ReviewItemWidget(state.reviews[index]);
                              },
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text("No reviews yet.",style: TextStyle(color: MyColors.classicAdaptiveTextColor(context)),),
                            ),
                          ),
                    if (state is ReviewLoading)
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: 10,
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const ReviewShimmerLoadingWidget();
                          },
                        ),
                      ),
                    ReviewCommentBox(productId: widget.productId),
                  ],
                );
              },
            ),
      ),
    );
  }
}
