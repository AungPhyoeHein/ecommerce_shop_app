import 'package:ecommerce_shop_app/core/utils/constants/icon_constants.dart';
import 'package:ecommerce_shop_app/core/widgets/input_field.dart';
import 'package:ecommerce_shop_app/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({super.key});

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: _controller,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12),
        child: const SvgIcon(IconConstants.search, size: 20),
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
              icon: const SvgIcon(IconConstants.filterProduct, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
