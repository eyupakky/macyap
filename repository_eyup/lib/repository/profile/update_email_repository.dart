import 'package:dio/dio.dart';

abstract class IUpdateEmail {
  Future<String> updateEmail();
}

class UpdateEmail extends IUpdateEmail {
  Dio _dio;
  UpdateEmail(this._dio);

  @override
  Future<String> updateEmail() {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }
}
