import 'package:buddypay_digital_wallet/features/homepage/data/datasource/home_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/homepage/domain/repository/home_repository.dart';

class HomeRemoteRepository implements IHomeRepository {
  final HomeRemoteDatasource _remoteDatasource;

  HomeRemoteRepository(this._remoteDatasource);

  @override
  Future<int> getBalance() async {
    return await _remoteDatasource.fetchBalance();
  }

  @override
  Future<List<Map<String, dynamic>>> getStatement() async {
    return await _remoteDatasource.fetchStatement();
  }

  @override
  Future<List<dynamic>> getAllStatements() async {
    return await _remoteDatasource.fetchAllStatement();
  }

  @override
  Future<List<Map<String, dynamic>>> getUserDetails() async {
    return await _remoteDatasource.getUserDetail();
  }
}
