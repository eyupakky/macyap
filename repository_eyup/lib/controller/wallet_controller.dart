import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/payment_history_model.dart';
import 'package:repository_eyup/repository/wallet_repository.dart';

class WalletController{
  final IWalletRepository _walletRepository = WalletRepository(Dio());

  Future<String> getUserBalance(){
    return Future.value(_walletRepository.getUserBalance());
  }
  Future<PaymentHistoryModel> getPaymentLogs(){
    return Future.value(_walletRepository.getWalletHistory());
  }
  Future<String> createPayment(Map map){
    return Future.value(_walletRepository.createPayment(map));
  }
  Future<bool> checkTc(){
    return Future.value(_walletRepository.checkTc());
  }
  Future<BaseResponse> setTc(String? tc){
    return Future.value(_walletRepository.setTc(tc));
  }
  Future<BaseResponse> setPromosyon(String? promosyonKodu){
    return Future.value(_walletRepository.setPromosyonCode(promosyonKodu));
  }
}