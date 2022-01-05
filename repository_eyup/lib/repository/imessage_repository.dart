import 'package:dio/dio.dart';
import 'package:repository_eyup/model/message_model.dart';

abstract class IMessageRepository {
  Future<List<MessageModel>> getLazyMessages();
}

class MessageRepository extends IMessageRepository {
  Dio _dio;

  MessageRepository(this._dio);

  @override
  Future<List<MessageModel>> getLazyMessages() async {
    List<MessageModel> lazyList = [];
    var response = await _dio.get("path");
    response.data[""].map((item) {
      lazyList.add(MessageModel.fromJson(item));
    });
    return Future.value(lazyList);
  }
}
