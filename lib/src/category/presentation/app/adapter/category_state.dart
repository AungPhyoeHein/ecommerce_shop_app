part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

//Initial State
final class CategoryInitial extends CategoryState {}

//Success State
final class GotCategories extends CategoryState {
  const GotCategories(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

//Error State
final class CategoryError extends CategoryState {
  const CategoryError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

//Loading State
final class CategoryLoading extends CategoryState {
  const CategoryLoading();
}
