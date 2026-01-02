import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/model/category_model.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/category/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_shop_app/src/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImplementation implements CategoryRepository {
  const CategoryRepositoryImplementation(this._remoteDataSource);

  final CategoryRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Category>> getCategories() async {
    try {
      final List<CategoryModel> categories = await _remoteDataSource
          .getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
