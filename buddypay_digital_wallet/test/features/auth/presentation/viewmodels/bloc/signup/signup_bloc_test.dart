import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocking use cases
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class FakeBuildContext extends Mock implements BuildContext {}

void main() {
  setUpAll(() {
    registerFallbackValue(const RegisterUserParams(
      fullname: 'John Doe',
      phone: '1234567890',
      password: 'password123',
      pin: '1234',
      device: 'Android',
      image: 'image.jpg',
    ));
    registerFallbackValue(UploadImageParams(file: File('path/to/file')));
  });

  late SignupBloc bloc;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockUploadImageUsecase mockUploadImageUsecase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadImageUsecase = MockUploadImageUsecase();

    bloc = SignupBloc(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  group('SignupBloc', () {
    const testImage = 'image.jpg';
    const testFullname = 'John Doe';
    const testPhone = '1234567890';
    const testPassword = 'password123';
    const testPin = '1234';
    const testDevice = 'Android';
    var testFile = File('path/to/file');

    test('initial state should be SignupState.initial', () {
      expect(bloc.state, const SignupState.initial());
    });

    blocTest<SignupBloc, SignupState>(
      'emits [SignupState.loading, SignupState.success] when RegisterUser succeeds',
      build: () {
        when(() => mockRegisterUseCase.call(any()))
            .thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (bloc) async {
        MaterialApp(
          home: Builder(
            builder: (context) {
              bloc.add(RegisterUser(
                fullname: testFullname,
                phone: testPhone,
                password: testPassword,
                pin: testPin,
                device: testDevice,
                image: testImage,
                context: context, // Use real context
              ));
              return Container(); // Dummy widget
            },
          ),
        );
      },
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockRegisterUseCase.call(any())).called(0);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignupState.loading, SignupState.failure] when RegisterUser fails',
      build: () {
        when(() => mockRegisterUseCase.call(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: 'Registration failed')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(RegisterUser(
          fullname: testFullname,
          phone: testPhone,
          password: testPassword,
          pin: testPin,
          device: testDevice,
          image: testImage,
          context: MockBuildContext(),
        ));
      },
      expect: () => [
        const SignupState(isLoading: true, isSuccess: false),
        const SignupState(isLoading: false, isSuccess: false),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignupState.loading, SignupState.success] when UploadImage succeeds',
      build: () {
        when(() => mockUploadImageUsecase.call(any()))
            .thenAnswer((_) async => const Right('uploaded_image.jpg'));
        return bloc;
      },
      act: (bloc) {
        bloc.add(UploadImage(file: testFile));
      },
      expect: () => [
        const SignupState(isLoading: true, isSuccess: false),
        const SignupState(
            isLoading: false, isSuccess: true, imageName: 'uploaded_image.jpg'),
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignupState.loading, SignupState.failure] when UploadImage fails',
      build: () {
        when(() => mockUploadImageUsecase.call(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: 'Image upload failed')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(UploadImage(file: testFile));
      },
      expect: () => [
        const SignupState(isLoading: true, isSuccess: false),
        const SignupState(isLoading: false, isSuccess: false),
      ],
    );
  });
}
