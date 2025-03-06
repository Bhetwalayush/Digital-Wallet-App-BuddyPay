import 'package:buddypay_digital_wallet/features/homepage/domain/repository/home_repository.dart';

class HomeUseCase {
  final IHomeRepository _repository;

  HomeUseCase(this._repository);

  Future<int> executeBalance() async {
    return await _repository.getBalance();
  }

  Future<List<Map<String, dynamic>>> executeStatement() async {
    return await _repository.getStatement();
  }

  Future<List<dynamic>> executeAllStatements() async {
    return await _repository.getAllStatements();
  }

  Future<List<Map<String, dynamic>>> executeUserDetails() async {
    return await _repository.getUserDetails();
  }
}
