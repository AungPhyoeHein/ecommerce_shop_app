import 'package:flutter/material.dart';
import 'package:ecommerce_shop_app/src/user/presentation/widgets/profile_header.dart';
import 'package:ecommerce_shop_app/src/user/presentation/widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const path = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuItem(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.favorite_border,
              title: 'Wishlist',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.location_on_outlined,
              title: 'Shipping Address',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            ProfileMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                // Handle logout logic here
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
