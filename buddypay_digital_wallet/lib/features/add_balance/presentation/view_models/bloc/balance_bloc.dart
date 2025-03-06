import 'package:buddypay_digital_wallet/core/common/snackbar/my_snackbar.dart';
import 'package:buddypay_digital_wallet/features/add_balance/domain/use_case/balance_usecase.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/homepage_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final HomeCubit _homeCubit;
  final RechargeUseCase _sendCreditUseCase;

  BalanceBloc({
    required HomeCubit homeCubit,
    required RechargeUseCase sendCreditUseCase,
  })  : _homeCubit = homeCubit,
        _sendCreditUseCase = sendCreditUseCase,
        super(BalanceState.initial()) {
    // Handle navigation event
    on<NavigateHomeEvents>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });

    // Handle send credit event
    on<RechargeRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true)); // Set loading state

      final result = await _sendCreditUseCase(
        RechargeParams(
          code: event.code,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Failed to send credit: ${failure.message}",
            color: Colors.red,
          );
        },
        (_) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          add(
            NavigateHomeEvents(
              context: event.context,
              destination: const HomePage(),
            ),
          );
        },
      );
    });
  }
}
