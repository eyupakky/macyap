import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/repository/ilogin_repository.dart';

class LoginController {
  ILoginRepository loginRepository = LoginRepository(Dio());
  Future<String> login(String email, String password) {
    return Future.value(loginRepository.login(email, password));
  }

  Future<Map<String, dynamic>> loginWithPhone(String phoneNumber) {
    return Future.value(loginRepository.loginWithPhone(phoneNumber));
  }

  Future<bool> isPhoneInDatabase(String phoneNumber) {
    return Future.value(loginRepository.isPhoneInDatabase(phoneNumber));
  }

  Future<BaseResponse> help(Map<String, String> map) {
    return Future.value(loginRepository.help(map));
  }
}
