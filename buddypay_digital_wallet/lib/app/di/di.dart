import 'package:buddypay_digital_wallet/core/network/hive_service.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  await _initLandingPageDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashDependencies();
  await _initOnboardingDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initSplashDependencies() async {
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

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use case
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initLandingPageDependencies() async {
  getIt.registerLazySingleton<LandingPageCubit>(
    () => LandingPageCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
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

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<LandingPageCubit>(
      create: (_) => getIt<LandingPageCubit>(),
    ),
    BlocProvider<SignupBloc>(
      create: (_) => getIt<SignupBloc>(),
    ),
    BlocProvider<LoginBloc>(
      create: (_) => getIt<LoginBloc>(),
    ),
    BlocProvider<SplashCubit>(
      create: (_) => getIt<SplashCubit>(),
    ),
    BlocProvider<OnboardingCubit>(
      create: (_) => getIt<OnboardingCubit>(),
    ),
  ];
}
