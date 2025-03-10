import 'dart:io';

import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String phone, String password);

  Future<void> registerUser(AuthEntity user);

  Future<void> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
