import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';

typedef DataMap = Map<String, dynamic>;

typedef ResultFuture<T> = Future<Either<Failure, T>>;
