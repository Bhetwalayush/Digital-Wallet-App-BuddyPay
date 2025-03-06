part of 'balance_bloc.dart';

class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object> get props => [];
}

// Event to initiate the send credit process
class RechargeRequested extends BalanceEvent {
  final String code;

  final BuildContext context;

  const RechargeRequested({
    required this.code,
    required this.context,
  });
}

// Event to navigate to the Home screen after sending credit
class NavigateHomeEvents extends BalanceEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeEvents({
    required this.context,
    required this.destination,
  });
}
