import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerImagesWidget extends StatefulWidget {
  const BannerImagesWidget({super.key});

  @override
  State<BannerImagesWidget> createState() => _BannerImagesWidgetState();
}

class _BannerImagesWidgetState extends State<BannerImagesWidget> {
  static const int _bannerCount = 4;

  int _activeIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _bannerCount,
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            aspectRatio: context.width < 500 ? 16 / 9 : 2.5,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, _) {
              setState(() => _activeIndex = index);
            },
          ),
          itemBuilder: (_, index, __) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/carousel.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: _activeIndex,
          count: _bannerCount,
          effect: ExpandingDotsEffect(
            dotHeight: 10,
            dotWidth: 10,
            dotColor: CoreUtils.adaptiveColor(
              context,
              lightModeColor: MyColors.lightThemePrimaryColor.withOpacity(0.3),
              darkModeColor: MyColors.lightThemeSecondaryTextColor,
            ),
            activeDotColor: CoreUtils.adaptiveColor(
              context,
              lightModeColor: MyColors.lightThemePrimaryColor,
              darkModeColor: MyColors.lightThemePrimaryColor,
            ),
          ),
          onDotClicked: _controller.animateToPage,
        ),
      ],
    );
  }
}
