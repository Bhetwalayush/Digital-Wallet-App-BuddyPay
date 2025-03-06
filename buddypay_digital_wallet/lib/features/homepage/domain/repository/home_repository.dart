abstract class IHomeRepository {
  Future<int> getBalance();
  Future<List<Map<String, dynamic>>> getStatement();
  Future<List<dynamic>> getAllStatements();
  Future<List<Map<String, dynamic>>> getUserDetails();
}
