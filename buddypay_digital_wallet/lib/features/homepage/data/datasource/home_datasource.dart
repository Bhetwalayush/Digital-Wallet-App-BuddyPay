abstract class IHomeDatasource {
  Future<int> fetchBalance();
  Future<List<Map<String, dynamic>>> fetchStatement();
  Future<List<dynamic>> fetchAllStatement();
  Future<List<Map<String, dynamic>>> getUserDetail();
}
