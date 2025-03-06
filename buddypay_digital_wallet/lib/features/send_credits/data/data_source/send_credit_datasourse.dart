abstract interface class ISendCreditRemoteDataSource {
  Future<String> sendCredit(String recipientNumber, double amount);
}
