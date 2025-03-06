abstract interface class IRechargeRemoteDataSource {
  Future<String> recharge(String code);
}
