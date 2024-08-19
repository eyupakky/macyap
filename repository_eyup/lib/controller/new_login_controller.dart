import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/repository/inew_login_repository.dart';

class NewLoginController {
  INewLoginRepository newLoginRepository = NewLoginRepository(Dio());
  Future<String> login(String phoneNumber) {
    return Future.value(newLoginRepository.login(phoneNumber));
  }

  Future<BaseResponse> help(Map<String, String> map) {
    return Future.value(newLoginRepository.help(map));
  }
}
