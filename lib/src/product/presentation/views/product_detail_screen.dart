import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/image_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.data});

  final DataMap data;

  static const path = "/products/";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 300,
            child: Hero(
              tag: widget.data['hero'],
              child: widget.data['image'] != null
                  ? Stack(
                      children: [
                        CarouselSlider.builder(
                          itemCount: 4,
                          carouselController: _carouselSliderController,
                          itemBuilder: (context, index, realIndex) =>
                              Image.network(
                                widget.data['image'],
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
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 50,
                          right: 50,
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  _carouselSliderController.animateToPage(
                                    index,
                                  );
                                },
                                child: ImageIndicatorWidget(
                                  widget.data["image"],
                                  isActive: _currentIndex == index,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: Icon(
                                  CupertinoIcons.back,
                                  color: MyColors.darkThemeDarkSharpColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Shimmer.fromColors(
                      baseColor: CoreUtils.adaptiveColor(
                        context,
                        lightModeColor: Colors.grey.shade300,
                        darkModeColor: Colors.grey.shade800,
                      ),
                      highlightColor: CoreUtils.adaptiveColor(
                        context,
                        lightModeColor: Colors.grey.shade100,
                        darkModeColor: Colors.grey.shade500,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(child: Container(color: Colors.white)),
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(height: 2000),
        ],
      ),
    );
  }
}
