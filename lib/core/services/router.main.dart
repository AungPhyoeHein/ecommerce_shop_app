part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final cacheHelper = sl<CacheHelper>()
          ..getSessionToken()
          ..getUserId();

        debugPrint(Cache.instance.sessionToken);
        if ((Cache.instance.sessionToken == null ||
                Cache.instance.userId == null) &&
            !cacheHelper.isFirstTime()) {
          return LoginScreen.path;
        }

        if (state.extra == 'home') return HomeScreen.path;

        return null;
      },
      builder: (_, __) {
        final cacheHelper = sl<CacheHelper>()
          ..getSessionToken()
          ..getUserId();

        if (cacheHelper.isFirstTime()) {
          return OnBoardingScreen();
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthCubit>()),
            BlocProvider(create: (_) => sl<AuthUserCubit>()),
          ],
          child: const SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: LoginScreen.path,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: RegistrationScreen.path,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const RegistrationScreen(),
      ),
    ),
    GoRoute(
      path: ForgotPasswordScreen.path,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: VerifyOTPScreen.path,
      builder: (_, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: VerifyOTPScreen(email: state.extra as String),
      ),
    ),
    GoRoute(
      path: ResetPasswordScreen.path,
      builder: (_, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: ResetPasswordScreen(email: state.extra as String),
      ),
    ),

    ShellRoute(
      builder: (context, state, child) =>
          DashboardScreen(state: state, child: child),
      routes: [
        GoRoute(
          path: HomeScreen.path,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
  ],
);
