import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/core/widgets/ecomi_logo.dart';
import 'package:ecommerce_shop_app/core/widgets/product_card.dart';
import 'package:ecommerce_shop_app/core/widgets/svg_icon.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/category_cubit.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/category_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/news_page_view.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/search_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const path = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: EcomiLogo(style: TextStyles.headingBold1),
        leading: IconButton(
          icon: SvgIcon('menu'),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: SvgIcon('shopping-cart')),
          IconButton(onPressed: () {}, icon: SvgIcon('qr-scan')),
        ],
        bottom: AppBarBottom(),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            children: [
              SearchInputWidget(),
              const Gap(20),
              NewsPageView(),
              const Gap(20),
              CategoryWidget(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: 'IPHONE 15 Prox Max',
                    description:
                        'This is IPhone 15 prox max offical version && brand new.',
                    image:
                        'https://www.imagineonline.store/cdn/shop/files/iPhone_15_Pro_Max_Blue_Titanium_PDP_Image_Position-1__en-IN.jpg',
                    price: 799.98,
                    colors: [Colors.black, Colors.white],
                  ); // သင့်ရဲ့ Product Card Widget
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(backgroundColor: MyColors.darkThemeDarkNavBarColor),
    );
  }
}
