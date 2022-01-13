class CityModel {
  bool? success;
  List<Cities>? cities;

  CityModel({this.success, this.cities});

  CityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      cities = <Cities>[];
      json['value'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (cities != null) {
      data['value'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? il;

  Cities({this.id, this.il});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    il = json['il'];
  }
  String getCities(){
    return il??"";
  }
  bool isEqual(Cities? model) {
    return id == model?.id;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['il'] = il;
    return data;
  }
}