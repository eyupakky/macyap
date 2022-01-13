class GameDetail {
  bool? success;
  int? limit;
  int? userId;
  String? gun;
  String? ay;
  String? yil;
  String? gameStart;
  String? gameVenueName;
  String? gameVenueAddres;
  int? gameVenueId;
  double? gamePrice;
  String? gender;
  String? gameDesc;
  String? orgUsername;
  String? gameOrg;
  int? gamerKalan;
  String? orgImage;
  String? imageVenue;
  int? acikSaha;
  int? kapaliSaha;
  int? cafeteria;
  int? wifi;
  int? ccard;
  int? opark;
  int? ayakkabiKira;
  int? servis;
  int? dus;
  String? description;
  String? locationX;
  String? locationY;
  List<String>? tags=[];
  GameDetail();

  GameDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    limit = json['limit'];
    userId = json['user_id'];
    gun = json['gun'];
    ay = json['ay'];
    yil = json['yil'];
    gameStart = json['game_start'];
    gameVenueName = json['gameVenueName'];
    gameVenueAddres = json['gameVenueAddres'];
    gameVenueId = json['game_venue_id'];
    orgUsername = json['org_username'];
    gamePrice = json['gamePrice'];
    gender = json['gender'];
    gameDesc = json['gameDesc'];
    gameOrg = json['gameOrg'];
    gamerKalan = json['gamerKalan'];
    orgImage = json['org_image'];
    imageVenue = json['image_venue'];
    acikSaha = json['acik_saha'];
    kapaliSaha = json['kapali_saha'];
    cafeteria = json['cafeteria'];
    wifi = json['wifi'];
    ccard = json['ccard'];
    opark = json['opark'];
    ayakkabiKira = json['ayakkabi_kira'];
    servis = json['servis'];
    dus = json['dus'];
    locationX = json['location_x'];
    locationY = json['location_y'];
    description = json['description'];
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
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['success'] = success;
  //   data['user_id'] = userId;
  //   data['gun'] = gun;
  //   data['ay'] = ay;
  //   data['yil'] = yil;
  //   data['game_start'] = gameStart;
  //   data['gameVenueName'] = gameVenueName;
  //   data['gameVenueAddres'] = gameVenueAddres;
  //   data['game_venue_id'] = gameVenueId;
  //   data['gamePrice'] = gamePrice;
  //   data['gender'] = gender;
  //   data['gameDesc'] = gameDesc;
  //   data['gameOrg'] = gameOrg;
  //   data['gamerKalan'] = gamerKalan;
  //   data['org_image'] = orgImage;
  //   data['image_venue'] = imageVenue;
  //   data['acik_saha'] = acikSaha;
  //   data['kapali_saha'] = kapaliSaha;
  //   data['cafeteria'] = cafeteria;
  //   data['wifi'] = wifi;
  //   data['ccard'] = ccard;
  //   data['opark'] = opark;
  //   data['ayakkabi_kira'] = ayakkabiKira;
  //   data['servis'] = servis;
  //   data['dus'] = dus;
  //   data['org_username'] = orgUsername;
  //   data['description'] = description;
  //   return data;
  // }
}