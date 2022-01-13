import 'package:dio/src/dio.dart';

import '../constant.dart';

abstract class IWalletRepository{
  Future<List<String>> getWalletHistory();
  Future<String> addMoney();
  Future<String> getUserBalance();
}

class WalletRepository extends IWalletRepository{
  Dio _dio;
  WalletRepository(this._dio);

  @override
  Future<String> addMoney() {
    return Future.value("");
  }

  @override
  Future<List<String>> getWalletHistory() {
    return Future.value([]);
  }

  @override
  Future<String> getUserBalance()async {
    var response = await _dio.post(Constant.baseUrl + Constant.getUserBalance,
        data: {
          "access_token": Constant.accessToken
        }).catchError((err) {
      print(err);
    });
    return Future.value(response.data["balance"]);
  }
}