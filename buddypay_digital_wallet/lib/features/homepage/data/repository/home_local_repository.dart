import 'package:buddypay_digital_wallet/features/homepage/data/datasource/home_local_datasource.dart';
import 'package:buddypay_digital_wallet/features/homepage/domain/repository/home_repository.dart';

class HomeLocalRepository implements IHomeRepository {
  final HomeLocalDatasource _localDatasource;

  HomeLocalRepository(this._localDatasource);

  @override
  Future<int> getBalance() async {
    return await _localDatasource.fetchBalance();
  }

  @override
  Future<List<Map<String, dynamic>>> getStatement() async {
    return await _localDatasource.fetchStatement();
  }

  @override
  Future<List<dynamic>> getAllStatements() async {
    return await _localDatasource.fetchAllStatement();
  }

  @override
  Future<List<Map<String, dynamic>>> getUserDetails() async {
    return await _localDatasource.getUserDetail();
  }
}
