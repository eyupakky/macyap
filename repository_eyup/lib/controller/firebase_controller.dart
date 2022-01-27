import 'package:dio/dio.dart';
import 'package:repository_eyup/repository/ifirebase_repository.dart';

class FirebaseController {
  final IFirebaseRepository _iFirebaseRepository = FirebaseRepository(Dio());

  Future<bool> sendGuid(String guid){
    return _iFirebaseRepository.sendGuid(guid);
  }
  Future<bool> sendLocation(double locationX,double locationY){
    return _iFirebaseRepository.sendLocation(locationX,locationY);
  }
}