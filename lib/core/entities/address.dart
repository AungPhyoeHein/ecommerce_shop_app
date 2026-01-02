import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    this.street,
    this.apartment,
    this.city,
    this.postalCode,
    this.country,
  });
  bool get isEmpty =>
      street == null &&
      apartment == null &&
      city == null &&
      postalCode == null &&
      country == null;

  bool get isNotEmpty => !isEmpty;

  final String? street;
  final String? apartment;
  final String? city;
  final String? postalCode;
  final String? country;

  @override
  List<Object?> get props => [street, apartment, city, postalCode, country];
}
