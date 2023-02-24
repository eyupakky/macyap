class UrunDetailModel {
  bool? success;
  UrunDetail? value;

  UrunDetailModel({this.success, this.value});

  UrunDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    value =
        json['value'] != null ? UrunDetail.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (value != null) {
      data['value'] = value!.toJson();
    }
    return data;
  }
}

class UrunDetail {
  int? id;
  String? img;
  String? img2;
  String? img3;
  String? img4;
  String? baslik;
  double? fiyat;
  String? aciklama;
  List<BedenList>? bedenList;

  UrunDetail(
      {this.id,
      this.img,
      this.img2,
      this.img3,
      this.img4,
      this.baslik,
      this.fiyat,
      this.aciklama,
      this.bedenList});

  UrunDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    baslik = json['baslik'];
    fiyat = json['fiyat'];
    aciklama = json['aciklama'];
    if (json['bedenList'] != null) {
      bedenList = <BedenList>[];
      json['bedenList'].forEach((v) {
        bedenList!.add(BedenList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    data['img2'] = img2;
    data['img3'] = img3;
    data['img4'] = img4;
    data['baslik'] = baslik;
    data['fiyat'] = fiyat;
    data['aciklama'] = aciklama;
    if (bedenList != null) {
      data['bedenList'] = bedenList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BedenList {
  String? beden;
  int? stok;

  BedenList({this.beden, this.stok});

  BedenList.fromJson(Map<String, dynamic> json) {
    beden = json['beden'];
    stok = json['stok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beden'] = beden;
    data['stok'] = stok;
    return data;
  }
}
