class CountiesModel {
  bool? success;
  List<Counties>? counties;

  CountiesModel({this.success, this.counties});

  CountiesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      counties = <Counties>[];
      json['value'].forEach((v) {
        counties!.add(Counties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (counties != null) {
      data['value'] = counties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Counties {
  int? id;
  String? ilce;
  int? ilId;

  Counties({this.id, this.ilce, this.ilId});

  Counties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ilce = json['ilce'];
    ilId = json['il_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ilce'] = this.ilce;
    data['il_id'] = this.ilId;
    return data;
  }
}
