import 'package:dio/src/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

abstract class IWalletRepository{
  Future<List<String>> getWalletHistory();
  Future<String> addMoney();
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
}