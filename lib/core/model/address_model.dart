import 'dart:convert';

import 'package:ecommerce_shop_app/core/entities/address.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

class AddressModel extends Address {
  const AddressModel({
    super.street,
    super.apartment,
    super.city,
    super.postalCode,
    super.country,
  });

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() {
    return {
      'street': street,
      'apartment': apartment,
      'city': city,
      'postalCode': postalCode,
      'country': country,
    };
  }

  factory AddressModel.fromMap(DataMap map) {
    return AddressModel(
      street: map['street'] as String?,
      apartment: map['apartment'] as String?,
      city: map['city'] as String?,
      postalCode: map['postalCode'] as String?,
      country: map['country'] as String?,
    );
  }

  const AddressModel.empty()
    : this(
        street: 'Test Street',
        apartment: 'Test Apartment',
        city: 'Test City',
        postalCode: 'Test Postal',
        country: 'Test Country',
      );
}
