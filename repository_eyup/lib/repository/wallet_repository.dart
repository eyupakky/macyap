import 'package:dio/src/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/payment_history_model.dart';

import '../constant.dart';

abstract class IWalletRepository {
  Future<PaymentHistoryModel> getWalletHistory();

  Future<String> addMoney();

  Future<String> getUserBalance();

  Future<String> createPayment(Map map);

  Future<bool> checkTc();

  Future<BaseResponse> setTc(String? tc);
}

class WalletRepository extends IWalletRepository {
  Dio _dio;

  WalletRepository(this._dio);

  @override
  Future<String> addMoney() {
    return Future.value("");
  }

  @override
  Future<PaymentHistoryModel> getWalletHistory() async {
    var response = await _dio.post(Constant.baseUrl + Constant.getPaymentLogs,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      return Future.error(err);
    });
    if (response.data["success"]) {
      return Future.value(PaymentHistoryModel.fromJson(response.data));
    } else {
      return Future.error("error");
    }
  }

  @override
  Future<String> getUserBalance() async {
    var response = await _dio.post(Constant.baseUrl + Constant.getUserBalance,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      print(err);
    });
    return Future.value(response.data["balance"].toString());
  }

  @override
  Future<String> createPayment(Map map) async {
    map.putIfAbsent("access_token", () => Constant.accessToken);
    var response = await _dio
        .post('https://macyap.com.tr/tr/' + Constant.payment, data: map)
        .catchError((err) {
      print(err);
    });
    if (response.data["Status"] == 1) {
      return Future.value(response.data["URL"].toString());
    } else {
      return Future.error(response.data["Message"]);
    }
  }

  @override
  Future<bool> checkTc() async {
    var response = await _dio.post(Constant.baseUrl + Constant.checkTCKNO,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      print(err);
      return Future.value(err);
    });
    return Future.value(response.data);
  }

  @override
  Future<BaseResponse> setTc(String? tc) async {
    var response = await _dio.post(Constant.baseUrl + Constant.setTc,
        data: {
          "access_token": Constant.accessToken,
          "tckno":"${tc}"
        }).catchError((err) {
      print(err);
      return Future.error(err);
    });
    var data = BaseResponse.fromJson(response.data);
    if (data.success!) {
      return Future.value(data);
    } else {
      return Future.error(data.description!);
    }
  }
}
