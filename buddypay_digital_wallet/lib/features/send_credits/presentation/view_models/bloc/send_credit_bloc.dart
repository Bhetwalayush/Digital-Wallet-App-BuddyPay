import 'package:buddypay_digital_wallet/core/common/snackbar/my_snackbar.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:buddypay_digital_wallet/features/send_credits/domain/use_case/send_credit_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../homepage/presentation/view/homepage_view.dart';

part 'send_credit_event.dart';
part 'send_credit_state.dart';

class SendCreditBloc extends Bloc<SendCreditEvent, SendCreditState> {
  final HomeCubit _homeCubit;
  final SendCreditUseCase _sendCreditUseCase;

  SendCreditBloc({
    required HomeCubit homeCubit,
    required SendCreditUseCase sendCreditUseCase,
  })  : _homeCubit = homeCubit,
        _sendCreditUseCase = sendCreditUseCase,
        super(SendCreditState.initial()) {
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
    on<SendCreditRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true)); // Set loading state

      final result = await _sendCreditUseCase(
        SendCreditParams(
          recipientNumber: event.recipientNumber,
          amount: event.amount,
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
