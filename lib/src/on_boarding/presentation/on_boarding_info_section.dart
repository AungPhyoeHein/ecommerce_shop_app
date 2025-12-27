import 'package:ecommerce_shop_app/core/common/app/cache_helper.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/media.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/injection_container.dart';

class OnBoardingInfoSection extends StatelessWidget {
  const OnBoardingInfoSection.first({super.key}) : first = true;
  const OnBoardingInfoSection.second({super.key}) : first = false;

  final bool first;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(first ? Media.onBoardingFemale : Media.onBoardingMale),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            first
                ? Text.rich(
                    textAlign: TextAlign.left,
                    style: TextStyles.headingBold.orange,
                    TextSpan(
                      text: '${DateTime.now().year}\n',
                      children: [
                        TextSpan(
                          text: 'Winter sale is live now',
                          style: TextStyle(
                            color: MyColors.classicAdaptiveTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  )
                : Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                      text: 'Flash Sale\n',
                      style: TextStyles.headingBold.adaptiveColor(context),
                      children: [
                        TextSpan(
                          text: 'Man\'s',
                          style: TextStyle(
                            color: MyColors.lightThemeSecondaryTextColor,
                          ),
                          children: [
                            TextSpan(
                              text: ' Shirts & Watchs',
                              style: TextStyle(
                                color: MyColors.classicAdaptiveTextColor(
                                  context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            RoundedButton(text: 'Get Started',onPressed: (){
              sl<CacheHelper>().cacheFirstTimer();
              context.go(LoginScreen.path);
            },)
          ],
        ),
      ],
    );
  }
}
