import 'package:equatable/equatable.dart';

class ServerException extends Equatable {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable {
  const CacheException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
