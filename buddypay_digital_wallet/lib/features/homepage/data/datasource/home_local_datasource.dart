import 'package:buddypay_digital_wallet/core/network/hive_service.dart';
import 'package:buddypay_digital_wallet/features/homepage/data/datasource/home_datasource.dart';
import 'package:buddypay_digital_wallet/features/homepage/data/model/home_hive_model.dart';

class HomeLocalDatasource implements IHomeDatasource {
  final HiveService _hiveService;

  HomeLocalDatasource(this._hiveService);

  @override
  Future<int> fetchBalance() async {
    try {
      final balanceData = await _hiveService.get('balance');
      if (balanceData != null) {
        return HomeHiveModel.fromJson(balanceData).balance;
      } else {
        throw Exception("No balance found in local storage");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchStatement() async {
    try {
      final statementData = await _hiveService.get('statements');
      if (statementData != null) {
        return [statementData];
      } else {
        throw Exception("No statements found in local storage");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchAllStatement() async {
    // Similar to fetchStatement, modify as needed
    return [];
  }

  @override
  Future<List<Map<String, dynamic>>> getUserDetail() async {
    try {
      final userDetail = await _hiveService.get('userDetail');
      if (userDetail != null) {
        return [userDetail];
      } else {
        throw Exception("No user details found in local storage");
      }
    } catch (e) {
      rethrow;
    }
  }
}
