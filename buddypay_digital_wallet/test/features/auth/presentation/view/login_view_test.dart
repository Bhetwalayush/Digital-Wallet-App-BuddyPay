import 'package:buddypay_digital_wallet/features/auth/presentation/view/login_view.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/landing_page/view/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes for SharedPreferences and LoginBloc
class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  group('LoginView Widget Tests', () {
    late MockSharedPreferences mockSharedPreferences;
    late MockLoginBloc mockLoginBloc;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      mockLoginBloc = MockLoginBloc();
    });

    testWidgets('Login form fields are empty initially', (tester) async {
      when(mockSharedPreferences.getString('phone')).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockLoginBloc,
            child: const LoginView(),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(
          find.byType(TextField).at(0).evaluate().single.widget,
          isA<TextField>()
              .having((e) => e.controller?.text, 'phone field', ''));
      expect(
          find.byType(TextField).at(1).evaluate().single.widget,
          isA<TextField>()
              .having((e) => e.controller?.text, 'password field', ''));
    });

    // Test: Verify fingerprint icon is shown when phone is loaded
    testWidgets('Fingerprint icon is shown when phone is loaded',
        (tester) async {
      when(mockSharedPreferences.getString('phone')).thenReturn('9876543210');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockLoginBloc,
            child: const LoginView(),
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget); // Fingerprint icon
    });

    // Test: Verify the close button navigates to LandingPage
    testWidgets('Close button navigates to LandingPage', (tester) async {
      when(mockSharedPreferences.getString('phone')).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockLoginBloc,
            child: const LoginView(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(LandingPage), findsOneWidget);
    });

    // Test: Verify password field obscures text
    testWidgets('Password field obscures text', (tester) async {
      when(mockSharedPreferences.getString('phone')).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockLoginBloc,
            child: const LoginView(),
          ),
        ),
      );

      final passwordField =
          tester.widget<TextField>(find.byType(TextField).at(1));
      expect(passwordField.obscureText, isTrue);
    });
  });
}
