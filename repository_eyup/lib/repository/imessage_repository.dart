import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/message_detail.dart';
import 'package:repository_eyup/model/message_model.dart';

abstract class IMessageRepository {
  Future<MessageModel> getLazyMessages();
  Future<MessageDetail> getDetail(int? id);
  Future<bool> sendMessage(int? id,String? message);
}

class MessageRepository extends IMessageRepository {
  Dio _dio;

  MessageRepository(this._dio);

  @override
  Future<MessageModel> getLazyMessages() async {
    var response = await _dio.post(Constant.baseUrl + Constant.getMyChatList,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      print(err);
    });
    return Future.value(MessageModel.fromJson(response.data));
  }

  @override
  Future<MessageDetail> getDetail(int? id) async{
    var response = await _dio.post(Constant.baseUrl + Constant.getMyChat,
        data: {"access_token": Constant.accessToken,"id":id}).catchError((err) {
      print(err);
    });
    return Future.value(MessageDetail.fromJson(response.data));
  }

  @override
  Future<bool> sendMessage(int? id, String? message)async {
    var response = await _dio.post(Constant.baseUrl + Constant.sendMessage,
        data: {"access_token": Constant.accessToken,"id":id,"message":message}).catchError((err) {
      print(err);
    });
    return Future.value(response.data);
  }
}
