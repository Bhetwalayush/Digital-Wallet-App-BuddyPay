import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'signup_user_usecase_test.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockTokenSharedPrefs tokenStorage;
  late LoginUseCase loginUseCase;

  const loginData = LoginParams(
    phone: "9876543210",
    password: "password",
  );

  const mockToken = "test_jwt_token";

  setUp(() {
    authRepository = MockAuthRepository();
    tokenStorage = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(authRepository, tokenStorage);

    // Register fallback values for custom classes
    registerFallbackValue(const LoginParams(phone: "dummy", password: "dummy"));
    registerFallbackValue("test_jwt_token");

    // Mock the behavior of token storage
    when(() => tokenStorage.saveToken(any()))
        .thenAnswer((_) async => const Right(null));
    when(() => tokenStorage.getToken())
        .thenAnswer((_) async => const Right(mockToken));
  });

  group('Login_Use_Case Tests', () {
    test('returns Failure when credentials are incorrect', () async {
      // Arrange
      when(() => authRepository.loginUser(any<String>(), any<String>()))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Invalid credentials")));

      // Act
      final result = await loginUseCase(loginData);

      // Assert
      expect(result, const Left(ApiFailure(message: "Invalid credentials")));
      verify(() => authRepository.loginUser(any<String>(), any<String>()))
          .called(1);
      verifyNever(() => tokenStorage.saveToken(any()));
    });

    test('returns Failure when phone is empty', () async {
      // Arrange
      const emptyPhoneData = LoginParams(phone: "", password: "password");
      when(() => authRepository.loginUser(any<String>(), any<String>()))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Phone number cannot be empty")));

      // Act
      final result = await loginUseCase(emptyPhoneData);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "Phone number cannot be empty")));
      verify(() => authRepository.loginUser(any<String>(), any<String>()))
          .called(1);
      verifyNever(() => tokenStorage.saveToken(any()));
    });

    test('returns Failure when password is empty', () async {
      // Arrange
      const emptyPasswordData = LoginParams(phone: "9876543210", password: "");
      when(() => authRepository.loginUser(any<String>(), any<String>()))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Password cannot be empty")));

      // Act
      final result = await loginUseCase(emptyPasswordData);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Password cannot be empty")));
      verify(() => authRepository.loginUser(any<String>(), any<String>()))
          .called(1);
      verifyNever(() => tokenStorage.saveToken(any()));
    });

    test('returns Failure on server error', () async {
      // Arrange
      when(() => authRepository.loginUser(any<String>(), any<String>()))
          .thenAnswer(
              (_) async => const Left(ApiFailure(message: "Server error")));

      // Act
      final result = await loginUseCase(loginData);

      // Assert
      expect(result, const Left(ApiFailure(message: "Server error")));
      verify(() => authRepository.loginUser(any<String>(), any<String>()))
          .called(1);
      verifyNever(() => tokenStorage.saveToken(any()));
    });

    test('logs in successfully ...', () async {
      // Arrange: Mock successful login response
      when(() => authRepository.loginUser(any(), any()))
          .thenAnswer((_) async => const Right(mockToken));

      // Act: Call the login use case
      final result = await loginUseCase(loginData);

      // Assert: Verify the expected results
      expect(result, const Right(mockToken));
      verify(() =>
              authRepository.loginUser(loginData.phone, loginData.password))
          .called(1);
      // verify(() => tokenStorage.saveToken(mockToken))
      //     .called(1);
      verifyNever(() => tokenStorage.getToken());
    });
  });
}
