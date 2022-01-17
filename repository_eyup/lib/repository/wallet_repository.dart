import 'package:dio/src/dio.dart';
import 'package:repository_eyup/model/payment_history_model.dart';

import '../constant.dart';

abstract class IWalletRepository{
  Future<PaymentHistoryModel> getWalletHistory();
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
  Future<PaymentHistoryModel> getWalletHistory()async {
    var response = await _dio.post(Constant.baseUrl + Constant.getPaymentLogs,
        data: {
          "access_token": Constant.accessToken
        }).catchError((err) {
      return Future.error(err);
    });
    if(response.data["success"]){
      return Future.value(PaymentHistoryModel.fromJson(response.data));
    }else{
      return Future.error("error");
    }
  }

  @override
  Future<String> getUserBalance()async {
    var response = await _dio.post(Constant.baseUrl + Constant.getUserBalance,
        data: {
          "access_token": Constant.accessToken
        }).catchError((err) {
      print(err);
    });
    return Future.value(response.data["balance"].toString());
  }
}