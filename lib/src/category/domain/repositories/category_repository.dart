import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

abstract class CategoryRepository {
  const CategoryRepository();

  ResultFuture<List<Category>> getCategories();
}
