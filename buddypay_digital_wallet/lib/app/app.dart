import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/core/app_theme/app_theme.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<LandingPageCubit>(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(
            registerUseCase: getIt<RegisterUseCase>(), // Inject RegisterUseCase
            uploadImageUsecase: getIt<UploadImageUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            signupBloc: context.read<SignupBloc>(),
            landingpageCubit: context.read<LandingPageCubit>(),
            loginUseCase: getIt<LoginUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BuddyPay',
        theme: getApplicationTheme(),
        initialRoute: AppRoute.splash_view,
        routes: AppRoute.getAppRoutes(),
      ),
    );
  }
}
