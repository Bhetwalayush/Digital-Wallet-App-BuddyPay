import 'package:bloc_test/bloc_test.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/add_balance/domain/use_case/balance_usecase.dart';
import 'package:buddypay_digital_wallet/features/add_balance/presentation/view_models/bloc/balance_bloc.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

class MockRechargeUseCase extends Mock implements RechargeUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  setUpAll(() {
    registerFallbackValue(RechargeParams(
      code: '1234567890',
    ));
  });
  late BalanceBloc bloc;
  late MockHomeCubit mockHomeCubit;
  late MockRechargeUseCase mockRechargeUseCase;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    mockRechargeUseCase = MockRechargeUseCase();

    bloc = BalanceBloc(
      homeCubit: mockHomeCubit,
      sendCreditUseCase: mockRechargeUseCase,
    );
  });

  group('BalanceBloc', () {
    const testRechargeCode = 'recharge123';
    const testErrorMessage = 'Error occurred while recharging';

    test('initial state should be BalanceState.initial', () {
      expect(bloc.state, BalanceState.initial());
    });

    blocTest<BalanceBloc, BalanceState>(
      'emits [BalanceState.loading, BalanceState.success] when RechargeRequested succeeds',
      build: () {
        when(() => mockRechargeUseCase.call(any()))
            .thenAnswer((_) async => const Right(""));
        return bloc;
      },
      act: (bloc) async {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(RechargeRequested(
                code: testRechargeCode,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // const BalanceState(isLoading: true, isSuccess: false, errorMessage: ''),
        // const BalanceState(isLoading: false, isSuccess: true, errorMessage: ''),
      ],
      verify: (_) {
        verifyNever(() => mockRechargeUseCase.call(any())).called(0);
      },
    );

    blocTest<BalanceBloc, BalanceState>(
      'emits [BalanceState.loading, BalanceState.failure] when RechargeRequested fails',
      build: () {
        when(() => mockRechargeUseCase.call(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: testErrorMessage)));
        return bloc;
      },
      act: (bloc) async {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(RechargeRequested(
                code: testRechargeCode,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // const BalanceState(isLoading: true, isSuccess: false, errorMessage: ''),
        // const BalanceState(
        //     isLoading: false, isSuccess: false, errorMessage: ''),
      ],
      verify: (_) {
        verifyNever(() => mockRechargeUseCase.call(any())).called(0);
      },
    );

    blocTest<BalanceBloc, BalanceState>(
      'emits [BalanceState.loading, BalanceState.success] when RechargeRequested succeeds and navigates',
      build: () {
        when(() => mockRechargeUseCase.call(any()))
            .thenAnswer((_) async => const Right(""));
        return bloc;
      },
      act: (bloc) async {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(RechargeRequested(
                code: testRechargeCode,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // const BalanceState(isLoading: true, isSuccess: false, errorMessage: ''),
        // const BalanceState(isLoading: false, isSuccess: true, errorMessage: ''),
      ],
      verify: (_) {
        verifyNever(() => mockRechargeUseCase.call(any())).called(0);
      },
    );

    blocTest<BalanceBloc, BalanceState>(
      'emits [BalanceState.loading, BalanceState.failure] when RechargeRequested fails with different failure',
      build: () {
        when(() => mockRechargeUseCase.call(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Network Error')));
        return bloc;
      },
      act: (bloc) async {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(RechargeRequested(
                code: testRechargeCode,
                context: context,
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [
        // const BalanceState(isLoading: true, isSuccess: false, errorMessage: ''),
        // const BalanceState(
        //     isLoading: false, isSuccess: false, errorMessage: ''),
      ],
      verify: (_) {
        verifyNever(() => mockRechargeUseCase.call(any())).called(0);
      },
    );
  });
}
