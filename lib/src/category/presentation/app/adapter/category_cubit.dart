import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/src/category/domain/usecases/get_categories.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required GetCategories getCategories})
    : _getCategories = getCategories,
      super(CategoryInitial());

  final GetCategories _getCategories;

  Future<void> getCategory() async {
    emit(CategoryLoading());
    final result = await _getCategories.call();
    result.fold((failure) => emit(CartegoryError(failure.errorMessage)), (
      categories,
    ) async {
      emit(GotCategories(categories));
    });
  }
}
