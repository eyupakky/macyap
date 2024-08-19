import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/repository/ilogin_repository.dart';

class LoginController {
  ILoginRepository loginRepository = LoginRepository(Dio());
  Future<String> login(String email, String password) {
    return Future.value(loginRepository.login(email, password));
  }

  Future<BaseResponse> help(Map<String, String> map) {
    return Future.value(loginRepository.help(map));
  }
}
