import 'package:dio/dio.dart';
import 'package:repository_eyup/model/city_model.dart';
import 'package:repository_eyup/model/count_model.dart';
import 'package:repository_eyup/repository/iregister_repository.dart';

class RegisterController {
  IRegisterRepository registerRepository = RegisterRepository(Dio());

  Future<List<Cities>> getCities() {
    return Future.value(registerRepository.getCities());
  }

  Future<List<Counties>> getCounties(int cityId) {
    return Future.value(registerRepository.getCounties(cityId));
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> map) {
    return Future.value(registerRepository.register(map));
  }
}
