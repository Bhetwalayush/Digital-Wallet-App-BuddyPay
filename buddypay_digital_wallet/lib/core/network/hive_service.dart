import 'package:buddypay_digital_wallet/app/constants/hive_table_constants.dart';
import 'package:buddypay_digital_wallet/features/auth/data/models/auth_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}buddy_pay.db';

    Hive.init(path);
    // ignore: avoid_print
    print("Database path: $path");
    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  // Future<void> deleteAuth(String id) async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
  //   await box.delete(id);
  // }

  // Future<List<AuthHiveModel>> getAllAuth() async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
  //   return box.values.toList();
  // }

  // Login using username and password
  Future<AuthHiveModel?> login(String phone, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.phone == phone && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  Future<void> save(String key, Map<String, dynamic> data) async {
    var box = await Hive.openBox('localStorage');
    await box.put(key, data);
  }

  Future<Map<String, dynamic>?> get(String key) async {
    var box = await Hive.openBox('localStorage');
    return box.get(key) as Map<String, dynamic>?;
  }
}
