import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsPageView extends StatefulWidget {
  const NewsPageView({super.key});

  @override
  State<NewsPageView> createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView> {
  // ၁။ PageController အစား လက်ရှိ index ကိုပဲ မှတ်ထားပါ
  double _activeIndex = 0;
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 4,
          carouselController: _carouselSliderController,
          options: CarouselOptions(
            // height: context.width < 500 ? 180 : 180 + (context.width - 500),
            autoPlay: true,
            viewportFraction: 1,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: false,
            aspectRatio: context.width < 500 ? 16 / 9 : 2.5,
            onScrolled: (value) {
              setState(() {
                _activeIndex = value! % 4;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) => Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/carousel.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SmoothIndicator(
            offset: _activeIndex,
            count: 4,
            key: UniqueKey(),
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              dotColor: CoreUtils.adaptiveColor(
                context,
                lightModeColor: MyColors.lightThemePrimaryColor.withOpacity(
                  0.3,
                ),
                darkModeColor: MyColors.lightThemeSecondaryTextColor,
              ),
              activeDotColor: CoreUtils.adaptiveColor(
                context,
                lightModeColor: MyColors.lightThemePrimaryColor,
                darkModeColor: MyColors.lightThemePrimaryColor,
              ),
            ),
            onDotClicked: (index) {
              _carouselSliderController.animateToPage(index);
            },
            size: Size(80, 20),
          ),
        ),
      ],
    );
  }
}
