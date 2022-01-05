import 'package:dio/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/message_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';
import 'package:repository_eyup/repository/imessage_repository.dart';

class MessageController {
  IMessageRepository iMessageRepository = MessageRepository(Dio());
  late List<MessageModel> messageList = [];

  Future<List<MessageModel>> getLazyMessage() async {
    if (messageList.isEmpty) {
      messageList = await iMessageRepository.getLazyMessages();
    }
    return messageList;
  }
}
