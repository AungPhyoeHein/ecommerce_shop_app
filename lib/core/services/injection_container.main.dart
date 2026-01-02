part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
  await _userInit();
  await _categoryInit();
}

Future<void> _userInit() async {
  sl
    ..registerFactory(
      () => AuthUserCubit(
        getUser: sl(),
        getUserPaymentProfile: sl(),
        updateUser: sl(),
        userProvider: sl(),
      ),
    )
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton(() => GetUserPaymentProfile(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImplementation(sl()),
    )
    ..registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImplementation(sl()),
    );
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthCubit(
        register: sl(),
        login: sl(),
        forgotPassword: sl(),
        verifyOTP: sl(),
        resetPassword: sl(),
        verifyToken: sl(),
        userProvider: sl(),
      ),
    )
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => Register(sl()))
    ..registerLazySingleton(() => ResetPassword(sl()))
    ..registerLazySingleton(() => VerifyOTP(sl()))
    ..registerLazySingleton(() => VerifyToken(sl()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplementation(sl()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(sl()),
    )
    ..registerLazySingleton(() => UserProvider.instance)
    ..registerLazySingleton(() => http.Client());
}

Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => (CacheHelper(sl())))
    ..registerLazySingleton(() => prefs);
}

Future<void> _categoryInit() async {
  sl
    ..registerFactory(() => CategoryCubit(getCategories: sl()))
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImplementation(sl()),
    )
    ..registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImplementation(sl()),
    );
}
