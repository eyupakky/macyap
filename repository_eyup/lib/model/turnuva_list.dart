class TurnuvaList{
  bool? success;
  List<Turnuvalar>? turnuvalar;
  TurnuvaList({this.success, this.turnuvalar});

  TurnuvaList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['turnuvalar'] != null) {
      turnuvalar = <Turnuvalar>[];
      json['turnuvalar'].forEach((v) {
        turnuvalar!.add(Turnuvalar.fromJson(v));
      });
    }
  }
}
class Turnuvalar{
  String? tBaslangic;
  String? tBitis;
  int? kAdet;
  String? turnuvaName;
  String? kBedeli;
  String? date;
  int? tip;
  String? aciklama;
  String? img;
  int? id;
  Turnuvalar(this.tBaslangic, this.tBitis, this.kAdet, this.turnuvaName,
      this.kBedeli, this.date, this.tip, this.aciklama, this.img, this.id);
  Turnuvalar.fromJson(Map<String, dynamic> json) {
    tBaslangic = json['t_baslangic'];
    tBitis = json['t_bitis'];
    kAdet = json['k_adet'];
    turnuvaName = json['turnuva_name'];
    kBedeli = json['k_bedeli'];
    date = json['date'];
    tip = json['tip'];
    aciklama = json['aciklama'];
    img = json['img'];
    id = json['id'];
  }
}