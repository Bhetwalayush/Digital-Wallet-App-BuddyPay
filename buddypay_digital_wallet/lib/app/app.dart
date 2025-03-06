import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/core/app_theme/app_theme.dart';
import 'package:buddypay_digital_wallet/features/add_balance/domain/use_case/balance_usecase.dart';
import 'package:buddypay_digital_wallet/features/add_balance/presentation/view_models/bloc/balance_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/theme_cubit.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/features/send_credits/domain/use_case/send_credit_usecase.dart';
import 'package:buddypay_digital_wallet/features/send_credits/presentation/view_models/bloc/send_credit_bloc.dart';
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
          create: (context) => SendCreditBloc(
            homeCubit: getIt<HomeCubit>(), // Inject RegisterUseCase
            sendCreditUseCase: getIt<SendCreditUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => BalanceBloc(
            homeCubit: getIt<HomeCubit>(), // Inject RegisterUseCase
            sendCreditUseCase: getIt<RechargeUseCase>(),
          ),
        ),
        // BlocProvider(
        //   create: (context) => LoginBloc(
        //     signupBloc: context.read<SignupBloc>(),
        //     landingpageCubit: context.read<LandingPageCubit>(),
        //     homeCubit: context.read<HomeCubit>(),
        //     loginUseCase: getIt<LoginUseCase>(),
        //   ),
        // ),
        BlocProvider(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BuddyPay',
            theme: AppThemes.getTheme(theme), // Apply dynamic theme
            initialRoute: AppRoute.splash_view,
            routes: AppRoute.getAppRoutes(),
          );
        },
      ),
    );
  }
}
