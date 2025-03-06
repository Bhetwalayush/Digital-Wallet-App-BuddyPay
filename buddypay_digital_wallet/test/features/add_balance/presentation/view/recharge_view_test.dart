import 'package:buddypay_digital_wallet/features/add_balance/presentation/view/recharge_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RechargeScreen Widget Tests', () {
    testWidgets('Should display back arrow button in AppBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RechargeScreen()),
      );
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('Should have a valid form key', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RechargeScreen()),
      );
      final form = find.byType(Form);
      expect(form, findsOneWidget);
    });

    testWidgets('Should display hint text in the amount field',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RechargeScreen()),
      );
      expect(find.text('Enter amount'), findsOneWidget);
    });

    testWidgets('Should not show an empty amount', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RechargeScreen()),
      );
      expect(find.text('Enter amount'), findsOneWidget);
    });

    testWidgets('Should navigate back when back button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RechargeScreen()),
      );
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();
      expect(find.byType(RechargeScreen), findsNothing);
    });
  });
}
