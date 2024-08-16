// ignore_for_file: unused_field, prefer_final_fields

import 'package:dio/dio.dart';

abstract class IUpdateEmail {
  Future<String> updateEmail();
}

class UpdateEmail extends IUpdateEmail {
  Dio _dio;
  UpdateEmail(this._dio);

  @override
  Future<String> updateEmail() {
    throw UnimplementedError();
  }
}
