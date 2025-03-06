// import 'package:buddypay_digital_wallet/features/homepage/cubit/homepage_cubit.dart';
// import 'package:buddypay_digital_wallet/viewmodels/bloc/login/login_bloc.dart';
// import 'package:buddypay_digital_wallet/viewmodels/bloc/signup/signup_bloc.dart';
// import 'package:get_it/get_it.dart';

// final serviceLocator = GetIt.instance;

// Future<void> intDependencies() async {
//   _initBloc();
//   _initCubit();
// }

// void _initBloc() {
//   serviceLocator.registerLazySingleton(() => SignupBloc());
//   serviceLocator.registerLazySingleton(() => LoginBloc());
// }

// void _initCubit() {
//   serviceLocator.registerLazySingleton<HomepageCubit>(
//     () => HomepageCubit(
//       serviceLocator(),
//       serviceLocator(),

//   ),
//   );
// }
