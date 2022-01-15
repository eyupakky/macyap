class MessageDetail {
  bool? success;
  List<MessageDetailItem>? messageDetailItem;

  MessageDetail({this.success, this.messageDetailItem});

  MessageDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      messageDetailItem = <MessageDetailItem>[];
      json['value'].forEach((v) {
        messageDetailItem!.add(MessageDetailItem.fromJson(v));
      });
    }
  }
}

class MessageDetailItem {
  int? msgId;
  int? userId;
  String? username;
  String? message;
  String? image;
  String? createdDate;

  MessageDetailItem(
      {this.msgId,
        this.userId,
        this.username,
        this.message,
        this.image,
        this.createdDate});

  MessageDetailItem.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    userId = json['user_id'];
    username = json['username'];
    message = json['message'];
    image = json['image'];
    createdDate = json['created_date'];
  }
}