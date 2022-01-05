import 'package:dio/dio.dart';

abstract class ISettingsRepository{
  Future<String> getUser();
  Future<String> updateImage();
  Future<String> updateUser();
}
class SettingsRepository extends ISettingsRepository{
  late Dio _dio;
  SettingsRepository(this._dio);
  @override
  Future<String> getUser() {
   return Future.value("");
  }

  @override
  Future<String> updateImage() {
    // TODO: implement updateImage
    throw UnimplementedError();
  }

  @override
  Future<String> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}