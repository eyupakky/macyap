import 'package:dio/dio.dart';
import 'package:repository_eyup/model/account_model.dart';
import 'package:repository_eyup/repository/iaccount_repository.dart';

class AccountController {
  IAccountRepository iAccountRepository = AccountRepository(Dio());
  late List<AccountModel> _accountModel;

  Future<List<AccountModel>> getAccount(String id) async {
    _accountModel = await iAccountRepository.getAccount(id);
    return _accountModel;
  }
}
