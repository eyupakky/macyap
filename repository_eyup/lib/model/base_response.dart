class BaseResponse {
  bool? success;
  String? description;

  BaseResponse({this.success, this.description});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
  }
}

class RatingResponse {
  bool? success;
  int? field;

  RatingResponse({this.success, this.field});

  RatingResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    field = json['field'];
  }
}
class BaseResponse2 {
  late bool success;
  String? description;

  BaseResponse2.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['value'];
  }
}
