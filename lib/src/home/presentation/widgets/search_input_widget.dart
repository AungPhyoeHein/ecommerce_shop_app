import 'package:ecommerce_shop_app/core/widgets/input_field.dart';
import 'package:ecommerce_shop_app/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  SearchInputWidget({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: searchController,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: const SvgIcon('search', size: 20),
      ),
      suffixIcon: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 1,
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgIcon('filter-product', size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
