class BaseResponse {
  bool? success;
  String? description;

  BaseResponse({this.success, this.description});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['description'] = description;
    return data;
  }
}