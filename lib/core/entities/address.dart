import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    this.street,
    this.apartment,
    this.city,
    this.postalCode,
    this.country,
  });

  const Address.empty()
    : street = 'Test Street',
      apartment = 'Test Apartment',
      city = 'Test City',
      postalCode = 'Test Postal',
      country = 'Test Country';

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

  DataMap toMap() {
    return {
      'street': street,
      'apartment': apartment,
      'city': city,
      'postalCode': postalCode,
      'country': country,
    };
  }

  factory Address.fromMap(DataMap map) {
    return Address(
      street: map['street'] as String?,
      apartment: map['apartment'] as String?,
      city: map['city'] as String?,
      postalCode: map['postalCode'] as String?,
      country: map['country'] as String?,
    );
  }

  @override
  List<Object?> get props => [street, apartment, city, postalCode, country];
}
