// import 'package:ecommerce_shop_app/core/entities/address.dart';
import 'dart:convert';

import 'package:ecommerce_shop_app/core/entities/address.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/core/model/address_model.dart';
import 'package:ecommerce_shop_app/src/wishlist/data/models/wishlist_product_model.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.isAdmin,
    required super.wishList,
    super.address,
    super.phone,
  });

  const UserModel.empty()
    : this(
        id: 'Test String',
        name: "Test String",
        email: "Test String",
        isAdmin: true,
        wishList: const [],
        address: null,
        phone: null,
      );

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'wishList': wishList
          .map((product) => (product as WishlistProductModel).toMap())
          .toList(),
      'address': address,
      'phone': phone,
    };
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromMap(DataMap map) {
    final address = AddressModel.fromMap({
      if (map case {'street': String street}) 'street': street,
      if (map case {'apartment': String apartment}) 'apartment': apartment,
      if (map case {'city': String city}) 'city': city,
      if (map case {'postalCode': String postalCode}) 'postalCode': postalCode,
      if (map case {'country': String country}) 'country': country,
    });
    return UserModel(
      id: (map['id'] ?? map['_id']) as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
      wishList: (map['wishList'] as List? ?? [])
          .map((item) => WishlistProductModel.fromMap(item as DataMap))
          .toList(),
      address: address as Address,
      phone: map['phone'] as String?,
    );
  }
}
