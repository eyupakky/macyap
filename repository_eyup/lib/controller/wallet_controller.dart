import 'package:dio/dio.dart';
import 'package:repository_eyup/repository/wallet_repository.dart';

class WalletController{
  IWalletRepository walletRepository = WalletRepository(Dio());

  Future<String> getUserBalance(){
    return Future.value(walletRepository.getUserBalance());
  }
}