import 'package:dio/dio.dart';
import 'package:repository_eyup/repository/ilogin_repository.dart';

class LoginController{
  ILoginRepository loginRepository = LoginRepository(Dio());
  Future<String> login(String email,String password){
    return Future.value(loginRepository.login(email, password));
  }

}