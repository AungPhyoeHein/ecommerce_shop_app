import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/delete_product_review.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/edit_product_review.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/get_product_reviews.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/leave_review.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:equatable/equatable.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({
    required LeaveReview leaveReview,
    required GetProductReviews getProductReview,
    required EditProductReview editProductReview,
    required DeleteProductReview deleteProductReview,
    required ProductCubit productCubit,
  }) : _leaveReview = leaveReview,
       _getProductReviews = getProductReview,
       _editProductReview = editProductReview,
       _deleteProductReview = deleteProductReview,
       _productCubit = productCubit,
       super(ReviewInitial());

  final LeaveReview _leaveReview;
  final GetProductReviews _getProductReviews;
  final EditProductReview _editProductReview;
  final DeleteProductReview _deleteProductReview;
  final ProductCubit _productCubit;

  Future<void> leaveReview({
    required String productId,
    required int rating,
    required String comment,
  }) async {
    emit(const ReviewLoading());
    final result = await _leaveReview.call(
      LeaveReviewParams(productId: productId, rating: rating, comment: comment),
    );

    result.fold((failure) => emit(ReviewError(failure.errorMessage)), (
      product,
    ) {
      _productCubit.emit(GotProduct(product));
      emit(const ReviewSuccess());
    });
  }

  Future<void> getProductReviews({
    required String productId,
    int page = 1,
  }) async {
    if (page == 1) {
      emit(const ReviewLoading());
    } else if (state is GotReviews) {
      _emitNextPageLoading(page);
    }

    final result = await _getProductReviews(
      GetProductReviewsParams(productId: productId, page: page),
    );

    result.fold(
      (failure) => emit(ReviewError(failure.errorMessage)),
      (reviews) => emit(
        GotReviews(
          reviews: reviews,
          isEnd: _isEndOfReviews(page, reviews),
          page: page,
        ),
      ),
    );
  }

  Future<void> editProductReview({
    required String productId,
    required String reviewId,
    required int rating,
    required String comment,
  }) async {
    final result = await _editProductReview.call(
      EditProductReviewParams(
        productId: productId,
        reviewId: reviewId,
        rating: rating,
        comment: comment,
      ),
    );

    result.fold((failure) => emit(ReviewError(failure.errorMessage)), (result) {
      _productCubit.getProductsById(productId);
      emit(const ReviewSuccess());
    });
  }

  Future<void> deleteProductReview({
    required String productId,
    required String reviewId,
  }) async {
    final result = await _deleteProductReview.call(
      DeleteProductReviewParams(productId: productId, reviewId: reviewId),
    );
    result.fold(
      (failure) => emit(ReviewError(failure.errorMessage)),
      (_) => emit(const DeletedReviewState()),
    );
  }

  void _emitNextPageLoading(int page) {
    if (state is GotReviews) {
      final currentState = state as GotReviews;
      emit(
        NextReviewLoading(
          page: page,
          reviews: currentState.reviews,
          isEnd: currentState.isEnd,
        ),
      );
    }
  }

  bool _isEndOfReviews(int page, List<Review> reviews) {
    return reviews.length < (page * NetworkConstants.pageSize);
  }
}
