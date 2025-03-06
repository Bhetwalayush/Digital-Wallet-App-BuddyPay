import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/repository/auth_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock the IAuthRepoitory
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const AuthEntity(
      fullname: 'Test User',
      phone: '9876543210',
      password: 'password123',
      pin: '1234',
      device: 'mobile',
      image: 'profile.jpg',
    ));
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockRepository);
  });

  // Test case for successful signup
  test('should call signupUser with correct AuthEntity and return void',
      () async {
    // Arrange
    const params = RegisterUserParams(
      fullname: 'John Doe',
      phone: '9876543210',
      password: 'password123',
      pin: '6565',
      device: 'mobile',
      image: 'profile.jpg',
    );

    const authEntity = AuthEntity(
      fullname: 'John Doe',
      phone: '9876543210',
      password: 'password123',
      pin: '6565',
      device: 'mobile',
      image: 'profile.jpg',
    );

    // Mock the repository to return Right(null) for successful signup
    when(() => mockRepository.registerUser(authEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Right(null)); // Verify that the result is Right(null)
    verify(() => mockRepository.registerUser(authEntity)).called(
        1); // Verify that signupUser was called with the correct AuthEntity
    verifyNoMoreInteractions(
        mockRepository); // Ensure no other interactions with the repository
  });

  // Test case for signup failure
  test('should return a Failure when signupUser fails', () async {
    // Arrange
    const params = RegisterUserParams(
      fullname: 'John Doe',
      phone: '9876543210',
      password: 'password123',
      pin: '6565',
      device: 'mobile',
      image: 'profile.jpg',
    );

    const authEntity = AuthEntity(
      fullname: 'John Doe',
      phone: '9876543210',
      password: 'password123',
      pin: '6565',
      device: 'mobile',
      image: 'profile.jpg',
    );

    const failure = ApiFailure(message: 'Signup failed');

    // Mock the repository to return Left(Failure) for failed signup
    when(() => mockRepository.registerUser(authEntity))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(
        result, const Left(failure)); // Verify that the result is Left(Failure)
    verify(() => mockRepository.registerUser(authEntity)).called(
        1); // Verify that signupUser was called with the correct AuthEntity
    verifyNoMoreInteractions(
        mockRepository); // Ensure no other interactions with the repository
  });
  test('returns Failure when pin is less than 4 digits', () async {
    // Arrange
    const invalidPinData = RegisterUserParams(
      fullname: 'John Doe',
      phone: '9876543210',
      password: 'password123',
      pin: '', // Empty pin
      device: 'mobile',
      image: 'profile.jpg',
    );

    when(() => mockRepository.registerUser(any<AuthEntity>())).thenAnswer(
        (_) async => const Left(ApiFailure(
            message: "Pin must be 4 digits"))); // Mock the failure response

    // Act
    final result = await useCase(invalidPinData);

    // Assert
    expect(result, const Left(ApiFailure(message: "Pin must be 4 digits")));
    verify(() => mockRepository.registerUser(any<AuthEntity>())).called(1);
    verifyNoMoreInteractions(
        mockRepository); // Ensure no further interactions with the repository
  });
  tearDown(() {
    reset(mockRepository); // Reset the mock after each test
  });
}
