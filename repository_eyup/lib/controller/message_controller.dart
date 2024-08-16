// ignore_for_file: unused_field

import 'package:dio/dio.dart';
import 'package:repository_eyup/model/message_detail.dart';
import 'package:repository_eyup/model/message_model.dart';
import 'package:repository_eyup/repository/imessage_repository.dart';

class MessageController {
  final IMessageRepository _iMessageRepository = MessageRepository(Dio());
  late MessageModel _messageList;

  Future<MessageModel> getLazyMessage() async {
    return _iMessageRepository.getLazyMessages();
  }

  Future<MessageDetail> getMessageDetail(int? id) async {
    return _iMessageRepository.getDetail(id);
  }

  Future<bool> sendMessage(int? id, String? message) async {
    return _iMessageRepository.sendMessage(id, message);
  }
}
