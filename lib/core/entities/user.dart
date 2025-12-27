import 'package:ecommerce_shop_app/core/entities/address.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.wishList,
    this.address,
    this.phone,
  });

  const User.empty()
    : id = 'Test String',
      name = "Test String",
      email = "Test String",
      isAdmin = true,
      wishList = const [],
      address = null,
      phone = null;

  User copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAdmin,
    List<WishlistProduct>? wishList,
    Address? address,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      wishList: wishList ?? this.wishList,
    );
  }

  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final List<WishlistProduct> wishList;
  final Address? address;
  final String? phone;

  @override
  List<Object?> get props => [id, name, email, isAdmin, wishList.length];
}
