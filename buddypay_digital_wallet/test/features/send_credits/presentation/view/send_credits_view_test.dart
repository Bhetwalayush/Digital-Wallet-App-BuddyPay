import 'package:buddypay_digital_wallet/features/send_credits/presentation/view/send_credits_view.dart';
import 'package:buddypay_digital_wallet/features/send_credits/presentation/view_models/bloc/send_credit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock classes for SendCreditBloc
class MockSendCreditBloc extends Mock implements SendCreditBloc {}

void main() {
  group('CreditScreen Widget Tests', () {
    late MockSendCreditBloc mockSendCreditBloc;

    setUp(() {
      mockSendCreditBloc = MockSendCreditBloc();
    });

    testWidgets('Recipient phone number field is displayed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(TextField).at(0), findsOneWidget);
    });

    testWidgets('Amount field is displayed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(TextField).at(1), findsOneWidget);
    });

    testWidgets('Recipient phone field pre-filled if phone is passed',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(phone: '9876543210'),
          ),
        ),
      );

      final recipientField =
          tester.widget<TextField>(find.byType(TextField).at(0));
      expect(recipientField.controller?.text, '9876543210');
    });

    testWidgets('Send Credit button is displayed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Recipient phone field displays the correct hint text',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(),
          ),
        ),
      );

      final recipientField =
          tester.widget<TextField>(find.byType(TextField).at(0));
      expect(recipientField.decoration?.hintText, '+977 9876543210');
    });

    testWidgets('Amount field displays the correct hint text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(),
          ),
        ),
      );

      final amountField =
          tester.widget<TextField>(find.byType(TextField).at(1));
      expect(amountField.decoration?.hintText, 'Amount');
    });

    testWidgets('Recipient phone field has the correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockSendCreditBloc,
            child: CreditScreen(),
          ),
        ),
      );

      final recipientField =
          tester.widget<TextField>(find.byType(TextField).at(0));
      expect(recipientField.style?.color, Colors.white);
    });
  });
}
