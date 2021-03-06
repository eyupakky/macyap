class MessageModel {
  bool? success;
  List<MessageItem>? messageItem;

  MessageModel({this.success, this.messageItem});

  MessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      messageItem = <MessageItem>[];
      json['value'].forEach((v) {
        messageItem!.add(MessageItem.fromJson(v));
      });
    }
  }

}

class MessageItem {
  int? userId;
  String? username;
  String? image;
  String? message;

  MessageItem({this.userId, this.username, this.image});

  MessageItem.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    image = json['image'];
    message = json['message'];
  }
}