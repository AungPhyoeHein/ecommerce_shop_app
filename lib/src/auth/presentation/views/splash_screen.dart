import 'package:ecommerce_shop_app/core/common/app/cache_helper.dart';
import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/services/injection_container.dart';
import 'package:ecommerce_shop_app/core/widgets/ecomi_logo.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:ecommerce_shop_app/src/user/app/adapter/auth_user_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().verifyToken();
  }

  Future<void> redirectToIndex() async {
    final router = GoRouter.of(context);
    await sl<CacheHelper>().resetSession();
    router.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthUserCubit, AuthUserState>(
      listener: (context, state) async {
        if (state is AuthUserError) {
          await redirectToIndex();
        } else if (state is GotUserData) {
          context.go('/', extra: 'home');
        }
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is TokenVerified) {
            if (state.isValid) {
              context.read<AuthUserCubit>().getUserById(Cache.instance.userId!);
            } else {
              await redirectToIndex();
            }
          } else if (state is AuthError) {
            await redirectToIndex();
          }
        },
        child: Scaffold(
          backgroundColor: MyColors.lightThemePrimaryColor,
          body: const Center(child: EcomiLogo()),
        ),
      ),
    );
  }
}
