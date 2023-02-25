class SiparisList {
  bool? success;
  List<SiparisItem>? value;

  SiparisList({this.success, this.value});

  SiparisList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      value = <SiparisItem>[];
      json['value'].forEach((v) {
        value!.add(SiparisItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (value != null) {
      data['value'] = value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SiparisItem {
  int? id;
  String? date;
  String? fiyat;
  String? baslik;
  String? color;
  String? durum;
  String? beden;
  String? adress;
  String? adet;
  String? kargoTakip;
  String? not;

  SiparisItem(
      {this.id,
        this.date,
        this.fiyat,
        this.baslik,
        this.color,
        this.durum,
        this.beden,
        this.adress,
        this.adet,
        this.kargoTakip,
        this.not});

  SiparisItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    fiyat = json['fiyat'];
    baslik = json['baslik'];
    color = json['color'];
    durum = json['durum'];
    beden = json['beden'];
    adress = json['adress'];
    adet = json['adet'];
    kargoTakip = json['kargoTakip'];
    not = json['not'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['fiyat'] = fiyat;
    data['baslik'] = baslik;
    data['color'] = color;
    data['durum'] = durum;
    data['beden'] = beden;
    data['adress'] = adress;
    data['adet'] = adet;
    data['kargoTakip'] = kargoTakip;
    data['not'] = not;
    return data;
  }
}