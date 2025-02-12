import 'package:buddypay_digital_wallet/app/shared_prefs/token_shared_prefs.dart';
import 'package:buddypay_digital_wallet/core/network/api_service.dart';
import 'package:buddypay_digital_wallet/core/network/hive_service.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initLandingPageDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSharedPreferences();
  await _initSplashScreenDependencies();
  await _initOnboardingDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
    // () => SplashCubit(getIt<LoginBloc>()),
  );
}

_initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LandingPageCubit>()),
    // () => SplashCubit(getIt<LoginBloc>()),
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use case
  // getIt.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initLandingPageDependencies() async {
  getIt.registerLazySingleton<LandingPageCubit>(
    () => LandingPageCubit(),
  );
}

_initLoginDependencies() async {
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      signupBloc: getIt<SignupBloc>(),
      landingpageCubit: getIt<LandingPageCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }
