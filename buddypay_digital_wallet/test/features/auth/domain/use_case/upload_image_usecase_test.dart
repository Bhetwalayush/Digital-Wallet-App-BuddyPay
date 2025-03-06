import 'dart:io';

import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/repository/auth_repository.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock the IAuthRepoitory
class MockAuthRepository extends Mock implements IAuthRepository {}

// Concrete subclass of Failure for testing
class TestFailure extends Failure {
  const TestFailure({required super.message});
}

void main() {
  late UploadImageUsecase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = UploadImageUsecase(mockRepository);
  });

  // Test case for successful image upload
  test(
      'should call uploadProfilePicture with correct File and return image URL',
      () async {
    // Arrange
    final file = File('/to/image.jpg');
    const imageUrl = 'https://example.com/image.jpg';

    // Mock the repository to return Right(imageUrl) for successful upload
    when(() => mockRepository.uploadProfilePicture(file))
        .thenAnswer((_) async => const Right(imageUrl));

    // Act
    final result = await useCase(UploadImageParams(file: file));

    // Assert
    expect(result,
        const Right(imageUrl)); // Verify that the result is Right(imageUrl)
    verify(() => mockRepository.uploadProfilePicture(file)).called(
        1); // Verify that uploadProfilePicture was called with the correct File
    verifyNoMoreInteractions(
        mockRepository); // Ensure no other interactions with the repository
  });

  // Test case for image upload failure
  test('should return a Failure when uploadProfilePicture fails', () async {
    // Arrange
    final file = File('path/to/image.jpg');
    const failure = TestFailure(message: 'Image upload failed');

    // Mock the repository to return Left(Failure) for failed upload
    when(() => mockRepository.uploadProfilePicture(file))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(UploadImageParams(file: file));

    // Assert
    expect(
        result, const Left(failure)); // Verify that the result is Left(Failure)
    verify(() => mockRepository.uploadProfilePicture(file)).called(
        1); // Verify that uploadProfilePicture was called with the correct File
    verifyNoMoreInteractions(
        mockRepository); // Ensure no other interactions with the repository
  });

  tearDown(() {
    reset(mockRepository); // Reset the mock after each test
  });
}
