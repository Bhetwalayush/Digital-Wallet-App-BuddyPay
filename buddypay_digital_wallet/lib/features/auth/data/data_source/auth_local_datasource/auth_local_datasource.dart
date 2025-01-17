import 'package:buddypay_digital_wallet/core/network/hive_service.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_data_source.dart';
import 'package:buddypay_digital_wallet/features/auth/data/models/auth_hive_model.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      userId: "1",
      fullname: "",
      phone: "",
      password: "",
      pin: "",
      device: "",
    ));
  }

  @override
  Future<String> loginUser(String phone, String password) async {
    try {
      await _hiveService.login(phone, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  // @override
  // Future<String> uploadProfilePicture(File file) {
  //   // TODO: implement uploadProfilePicture
  //   throw UnimplementedError();
  // }
}
