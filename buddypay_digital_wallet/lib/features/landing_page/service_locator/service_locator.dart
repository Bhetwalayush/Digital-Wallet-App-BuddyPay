// import 'package:buddypay_digital_wallet/domain/use_case/signup_user_usecase.dart';
// import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
// import 'package:buddypay_digital_wallet/viewmodels/bloc/login/login_bloc.dart';
// import 'package:buddypay_digital_wallet/viewmodels/bloc/signup/signup_bloc.dart';
// import 'package:get_it/get_it.dart';

// final serviceLocator = GetIt.instance;

// Future<void> intDependencies() async {
//   _initBloc();
//   _initCubit();
// }

// void _initBloc() {
//   // Register SignupBloc
//   serviceLocator.registerLazySingleton(
//     () => SignupBloc(registerUseCase: serviceLocator<RegisterUseCase>()),
//   );

//   // Register LandingPageCubit (if not already registered)
//   // serviceLocator.registerLazySingleton<LandingPageCubit>(
//   //   () => LandingPageCubit(serviceLocator(), serviceLocator()),
//   // );

//   // Register LoginBloc with required dependencies
//   serviceLocator.registerLazySingleton(
//     () => LoginBloc(
//       signupBloc: serviceLocator<SignupBloc>(),
//       landingpageCubit: serviceLocator<LandingPageCubit>(),
//     ),
//   );
// }

// void _initCubit() {
//   serviceLocator.registerLazySingleton<LandingPageCubit>(
//     () => LandingPageCubit(
//       serviceLocator(),
//       serviceLocator(),
//     ),
//   );
// }
