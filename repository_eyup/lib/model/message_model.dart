class MessageModel {
  late String message;
  late String image;
  late String date;

  MessageModel(
      {required this.message, required this.image, required this.date});

  MessageModel.fromJson(Map map) {
    message = map["message"];
    image = map["image"];
    date = map["date"];
  }
}
