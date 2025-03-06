part of 'balance_bloc.dart';

class BalanceState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const BalanceState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
  });

  // Initial state
  factory BalanceState.initial() {
    return const BalanceState(
      isLoading: false,
      isSuccess: false,
      errorMessage: '',
    );
  }

  // Copy with method to return a new state with updated values
  BalanceState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return BalanceState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isLoading, isSuccess, errorMessage];
}
