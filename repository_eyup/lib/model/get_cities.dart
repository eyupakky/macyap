class GetCities {
  bool? success;
  List<Cities>? cities;

  GetCities({this.success, this.cities});

  GetCities.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['il'] = il;
    return data;
  }
}