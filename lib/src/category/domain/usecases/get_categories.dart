import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/category/domain/repositories/category_repository.dart';

class GetCategories extends UsecaseWithoutParams<List<Category>> {
  const GetCategories(this._repository);

  final CategoryRepository _repository;

  @override
  ResultFuture<List<Category>> call() => _repository.getCategories();
}
