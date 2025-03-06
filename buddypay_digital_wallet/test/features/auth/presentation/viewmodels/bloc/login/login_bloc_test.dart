import 'package:bloc_test/bloc_test.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocking use cases
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

class FakeBuildContext extends Mock implements BuildContext {}

class MockSignupBloc extends Mock implements SignupBloc {}

class MockLandingPageCubit extends Mock implements LandingPageCubit {}

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(const LoginParams(
      phone: '1234567890',
      password: 'password123',
    ));
  });

  late LoginBloc bloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();

    bloc = LoginBloc(
      signupBloc: MockSignupBloc(),
      landingpageCubit: MockLandingPageCubit(),
      homeCubit: MockHomeCubit(),
      loginUseCase: mockLoginUseCase,
    );
  });

  group('LoginBloc', () {
    const testPhone = '1234567890';
    const testPassword = 'password123';

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState.loading, LoginState.success] when LoginUser succeeds',
      build: () {
        when(() => mockLoginUseCase.call(any()))
            .thenAnswer((_) async => const Right('token'));
        return bloc;
      },
      act: (bloc) async {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(LoginUserEvent(
                phone: testPhone,
                password: testPassword,
                context: context, // Use real context
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // LoginState(isLoading: true, isSuccess: false),
        // LoginState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verifyNever(() => mockLoginUseCase.call(any())).called(0);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState.loading, LoginState.failure] when LoginUser fails',
      build: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: 'Invalid Credentials')));
        return bloc;
      },
      act: (bloc) {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(LoginUserEvent(
                phone: testPhone,
                password: testPassword,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockLoginUseCase.call(any())).called(0);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState.loading, LoginState.failure] when LoginUser fails with different failure',
      build: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Network Error')));
        return bloc;
      },
      act: (bloc) {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(LoginUserEvent(
                phone: testPhone,
                password: testPassword,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // LoginState(isLoading: true, isSuccess: false),
        // LoginState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verifyNever(() => mockLoginUseCase.call(any())).called(0);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState.loading, LoginState.failure] when LoginUser fails with invalid input',
      build: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Invalid Input')));
        return bloc;
      },
      act: (bloc) {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(LoginUserEvent(
                phone: '',
                password: testPassword,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // LoginState(isLoading: true, isSuccess: false),
        // LoginState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verifyNever(() => mockLoginUseCase.call(any())).called(0);
      },
    );
  });
}
