part of 'send_credit_bloc.dart';

class SendCreditEvent extends Equatable {
  const SendCreditEvent();

  @override
  List<Object> get props => [];
}

// Event to initiate the send credit process
class SendCreditRequested extends SendCreditEvent {
  final String recipientNumber;
  final double amount;
  final BuildContext context;

  const SendCreditRequested({
    required this.recipientNumber,
    required this.amount,
    required this.context,
  });
}

// Event to navigate to the Home screen after sending credit
class NavigateHomeEvents extends SendCreditEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeEvents({
    required this.context,
    required this.destination,
  });
}
