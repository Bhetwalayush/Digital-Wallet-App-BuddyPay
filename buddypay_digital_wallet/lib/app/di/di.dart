import 'package:buddypay_digital_wallet/app/shared_prefs/token_shared_prefs.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/core/network/api_service.dart';
import 'package:buddypay_digital_wallet/core/network/hive_service.dart';
import 'package:buddypay_digital_wallet/features/add_balance/data/data_source/balance_datasourse.dart';
import 'package:buddypay_digital_wallet/features/add_balance/data/data_source/balance_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/add_balance/data/repository/balance_repository.dart';
import 'package:buddypay_digital_wallet/features/add_balance/domain/use_case/balance_usecase.dart';
import 'package:buddypay_digital_wallet/features/add_balance/presentation/view_models/bloc/balance_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/features/send_credits/data/data_source/send_credit_datasourse.dart';
import 'package:buddypay_digital_wallet/features/send_credits/data/data_source/send_credit_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/send_credits/data/repository/send_credit_repository.dart';
import 'package:buddypay_digital_wallet/features/send_credits/domain/use_case/send_credit_usecase.dart';
import 'package:buddypay_digital_wallet/features/send_credits/presentation/view_models/bloc/send_credit_bloc.dart';
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
  await _initHomeDependencies();
  await _initSharedPreferences();
  await _initSplashScreenDependencies();
  await _initOnboardingDependencies();
  await _initSendCreditDependencies();
  await _initRechargeDependencies();
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

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

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
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }
_initSendCreditDependencies() async {
  // Register Token & User Shared Preferences
  getIt.registerLazySingleton<UserSharedPrefs>(
    () => UserSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ISendCreditRemoteDataSource>(
    () => SendCreditRemoteDataSource(getIt<Dio>(), getIt<UserSharedPrefs>()),
  );

  // Register SendCreditRepositoryImpl
  getIt.registerLazySingleton<SendCreditRepositoryImpl>(
    () => SendCreditRepositoryImpl(getIt<ISendCreditRemoteDataSource>()),
  );

  // Register SendCreditUseCase
  getIt.registerLazySingleton<SendCreditUseCase>(
    () => SendCreditUseCase(
      getIt<SendCreditRepositoryImpl>(),
    ),
  );

  // Register SendCreditBloc
  getIt.registerFactory<SendCreditBloc>(
    () => SendCreditBloc(
      homeCubit: getIt<HomeCubit>(),
      sendCreditUseCase: getIt<SendCreditUseCase>(),
    ),
  );
}

_initRechargeDependencies() async {
  // Register Token & User Shared Preferences
  // getIt.registerLazySingleton<UserSharedPrefs>(
  //   () => UserSharedPrefs(getIt<SharedPreferences>()),
  // );

  getIt.registerLazySingleton<IRechargeRemoteDataSource>(
    () => RechargeRemoteDataSource(getIt<Dio>(), getIt<UserSharedPrefs>()),
  );

  // Register SendCreditRepositoryImpl
  getIt.registerLazySingleton<RechargeRepositoryImpl>(
    () => RechargeRepositoryImpl(getIt<IRechargeRemoteDataSource>()),
  );

  // Register SendCreditUseCase
  getIt.registerLazySingleton<RechargeUseCase>(
    () => RechargeUseCase(
      getIt<RechargeRepositoryImpl>(),
    ),
  );

  // Register SendCreditBloc
  getIt.registerFactory<BalanceBloc>(
    () => BalanceBloc(
      homeCubit: getIt<HomeCubit>(),
      sendCreditUseCase: getIt<RechargeUseCase>(),
    ),
  );
}
