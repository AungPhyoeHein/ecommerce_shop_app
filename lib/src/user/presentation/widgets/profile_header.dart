import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/services/injection_container.dart';
import 'package:ecommerce_shop_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = sl<UserProvider>();
    final l10n = AppLocalizations.of(context)!;
    
    return ListenableBuilder(
      listenable: userProvider,
      builder: (context, child) {
        final user = userProvider.currentUser;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.lightThemePrimaryColor.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.15),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: MyColors.adaptiveCardColor(context),
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: MyColors.adaptiveBackgroundColor(context),
                        child: Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: MyColors.lightThemePrimaryColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Change profile picture
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MyColors.lightThemePrimaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: MyColors.adaptiveCardColor(context), width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                user?.name ?? l10n.guestUser,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: MyColors.classicAdaptiveTextColor(context),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? l10n.joinCommunity,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: MyColors.adaptiveSecondaryTextColor(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
