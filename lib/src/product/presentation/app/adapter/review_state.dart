part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();
  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {
  const ReviewLoading();
}

class NextReviewLoading extends GotReviews {
  const NextReviewLoading({
    required super.reviews,
    required super.page,
    required super.isEnd,
  });
}

class GotReviews extends ReviewState {
  final List<Review> reviews;
  final int page;
  final bool isEnd;

  const GotReviews({
    required this.reviews,
    required this.page,
    required this.isEnd,
  });

  @override
  List<Object> get props => [reviews, page, isEnd];
}

class EditedReviewState extends ReviewState {
  const EditedReviewState({required this.product});

  final Product product;
}

class DeletedReviewState extends ReviewState {
  const DeletedReviewState();
}

class ReviewError extends ReviewState {
  const ReviewError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ReviewSuccess extends ReviewState {
  const ReviewSuccess();
}
