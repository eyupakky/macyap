import 'package:dio/dio.dart';
import 'package:repository_eyup/model/payment_history_model.dart';
import 'package:repository_eyup/repository/wallet_repository.dart';

class WalletController{
  IWalletRepository _walletRepository = WalletRepository(Dio());

  Future<String> getUserBalance(){
    return Future.value(_walletRepository.getUserBalance());
  }
  Future<PaymentHistoryModel> getPaymentLogs(){
    return Future.value(_walletRepository.getWalletHistory());
  }
}