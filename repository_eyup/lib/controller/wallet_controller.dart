import 'package:dio/dio.dart';
import 'package:repository_eyup/repository/wallet_repository.dart';

class WalletController{
  IWalletRepository _walletRepository = WalletRepository(Dio());

  Future<String> getUserBalance(){
    return Future.value(_walletRepository.getUserBalance());
  }
}