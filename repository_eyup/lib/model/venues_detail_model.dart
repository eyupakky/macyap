class VenusDetailModel {
  bool? sucsess;
  int? id;
  String? name;
  String? address;
  String? description;
  String? il;
  String? ilce;
  int? kapaliSaha;
  int? cafeteria;
  int? wifi;
  int? ccard;
  int? ayakkabiKira;
  int? servis;
  int? dus;
  int? acikSaha;
  int? opark;
  String? image;
  List<String>? tel;
  String? locationX;
  String? locationY;
  int? followers;
  bool? follow;
  List<String>? tags=[];
  VenusDetailModel(
      {this.sucsess,
        this.id,
        this.name,
        this.address,
        this.description,
        this.il,
        this.ilce,
        this.kapaliSaha,
        this.cafeteria,
        this.wifi,
        this.ccard,
        this.ayakkabiKira,
        this.servis,
        this.dus,
        this.acikSaha,
        this.image,
        this.tel,
        this.locationX,
        this.locationY,
        this.followers});

  VenusDetailModel.fromJson(Map<String, dynamic> json) {
    sucsess = json['sucsess'];
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    il = json['il'];
    ilce = json['ilce'];
    kapaliSaha = json['kapali_saha'];
    cafeteria = json['cafeteria'];
    wifi = json['wifi'];
    ccard = json['ccard'];
    ayakkabiKira = json['ayakkabi_kira'];
    servis = json['servis'];
    dus = json['dus'];
    acikSaha = json['acik_saha'];
    opark = json['opark'];
    image = json['image'];
    tel = json['tel'].toString().split("\\n");
    locationX = json['location_x'];
    locationY = json['location_y'];
    followers = json['followers'];
    follow = json['follow'];
    if(acikSaha==1)tags!.add("Açık saha");
    if(kapaliSaha==1)tags!.add("Kapalı saha");
    if(cafeteria==1)tags!.add("Cafeteria");
    if(wifi==1)tags!.add("Wifi");
    if(ccard==1)tags!.add("Kredi Kartı");
    if(opark==1)tags!.add("Otopark");
    if(ayakkabiKira==1)tags!.add("Ayakkabı kiralama");
    if(servis==1)tags!.add("Servis");
    if(dus==1)tags!.add("Duş");
  }

}