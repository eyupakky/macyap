class UrunlerDetailModel {
  bool? success;
  Detail? detail;
  List<BedenList>? bedenList;

  UrunlerDetailModel({this.success, this.detail, this.bedenList});

  UrunlerDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    if (json['bedenList'] != null) {
      bedenList = <BedenList>[];
      json['bedenList'].forEach((v) {
        bedenList!.add(BedenList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    if (bedenList != null) {
      data['bedenList'] = bedenList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? baslik;
  String? aciklama;
  String? img;
  String? img2;
  String? img3;
  String? img4;
  double? fiyat;
  String? barkod;
  String? date;
  String? updatedDate;
  int? active;

  Detail(
      {this.id,
      this.baslik,
      this.aciklama,
      this.img,
      this.img2,
      this.img3,
      this.img4,
      this.fiyat,
      this.barkod,
      this.date,
      this.updatedDate,
      this.active});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baslik = json['Baslik'];
    aciklama = json['Aciklama'];
    img = json['Img'];
    img2 = json['Img2'];
    img3 = json['Img3'];
    img4 = json['Img4'];
    fiyat = json['Fiyat'];
    barkod = json['Barkod'];
    date = json['Date'];
    updatedDate = json['UpdatedDate'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Baslik'] = this.baslik;
    data['Aciklama'] = this.aciklama;
    data['Img'] = this.img;
    data['Img2'] = this.img2;
    data['Img3'] = this.img3;
    data['Img4'] = this.img4;
    data['Fiyat'] = this.fiyat;
    data['Barkod'] = this.barkod;
    data['Date'] = this.date;
    data['UpdatedDate'] = this.updatedDate;
    data['Active'] = this.active;
    return data;
  }
}

class BedenList {
  int? id;
  int? urunId;
  double? urunFiyat;
  int? bedenId;
  int? stok;
  String? beden;

  BedenList(
      {this.id,
      this.urunId,
      this.urunFiyat,
      this.bedenId,
      this.stok,
      this.beden});

  BedenList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urunId = json['UrunId'];
    urunFiyat = json['UrunFiyat'];
    bedenId = json['BedenId'];
    stok = json['Stok'];
    beden = json['Beden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UrunId'] = this.urunId;
    data['UrunFiyat'] = this.urunFiyat;
    data['BedenId'] = this.bedenId;
    data['Stok'] = this.stok;
    data['Beden'] = this.beden;
    return data;
  }
}
