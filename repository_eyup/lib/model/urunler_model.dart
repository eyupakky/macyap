// ignore_for_file: prefer_collection_literals, unnecessary_this

class UrunlerModel {
  bool? success;
  List<Value>? value;

  UrunlerModel({this.success, this.value});

  UrunlerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  int? id;
  String? img;
  String? baslik;
  String? fiyat;

  Value({this.id, this.img, this.baslik, this.fiyat});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    baslik = json['baslik'];
    fiyat = json['fiyat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['baslik'] = this.baslik;
    data['fiyat'] = this.fiyat;
    return data;
  }
}
