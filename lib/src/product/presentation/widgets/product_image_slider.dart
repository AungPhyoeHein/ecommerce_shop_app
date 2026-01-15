import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/image_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  void _scrollToActiveIndicator(int index) {
    const double itemWidth = 60.0;

    double offset = (index - 1) * itemWidth;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int carouselCount = widget.images.length;
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: carouselCount,
          carouselController: _carouselSliderController,
          itemBuilder: (context, index, realIndex) => Image.network(
            widget.images[index],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              _scrollToActiveIndicator(index);
            },
          ),
        ),
        Positioned(
          bottom: 40,
          left: 50,
          right: 50,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: carouselCount,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  _carouselSliderController.animateToPage(index);
                },
                child: ImageIndicatorWidget(
                  widget.images[index],

                  isActive: _currentIndex == index,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Row(
            children: [
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: CoreUtils.adaptiveColor(
                    context,
                    lightModeColor: MyColors.lightThemeWhiteColor,
                    darkModeColor: MyColors.darkThemeDarkNavBarColor,
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: MyColors.classicAdaptiveTextColor(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
