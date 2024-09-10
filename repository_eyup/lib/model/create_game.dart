class CreateGame {
  String? accessToken;
  String? gameTitle;
  String? gameDesc;
  String? gameDate;
  int? gameLimit;
  String? gender;
  int? venueId;
  String? gamePrice;
  String? gameType;
  String? tagler;
  String? ozelSahaAdress;
  String? ozelSahaTel;
  String? ozelSahaIsim;
  int? ozelOyun;
  int? ksha;
  int? ksha1;

  CreateGame(
      {this.accessToken,
      this.gameTitle,
      this.gameDesc,
      this.gameDate,
      this.gameLimit,
      this.gender,
      this.venueId,
      this.gamePrice,
      this.gameType,
      this.tagler,
      this.ozelSahaAdress,
      this.ozelSahaTel,
      this.ozelSahaIsim,
      this.ozelOyun,
      this.ksha,
      this.ksha1});

  CreateGame.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    gameTitle = json['game_title'];
    gameDesc = json['game_desc'];
    gameDate = json['game_date'];
    gameLimit = json['game_limit'];
    gender = json['gender'];
    venueId = json['venue_id'];
    gamePrice = json['game_price'];
    gameType = json['game_type'];
    tagler = json['tagler'];
    ozelSahaAdress = json['ozel_saha_adress'];
    ozelSahaTel = json['ozel_Saha_tel'];
    ozelSahaIsim = json['ozel_saha_isim'];
    ozelOyun = json['ozel_oyun'];
    ksha = json['ksha'];
    ksha1 = json['ksha_1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['game_title'] = gameTitle;
    data['game_desc'] = gameDesc;
    data['game_date'] = gameDate;
    data['game_limit'] = gameLimit;
    data['gender'] = gender;
    data['venue_id'] = venueId;
    data['game_price'] = gamePrice;
    data['game_type'] = gameType;
    data['tagler'] = tagler;
    data['ozel_saha_adress'] = ozelSahaAdress;
    data['ozel_Saha_tel'] = ozelSahaTel;
    data['ozel_saha_isim'] = ozelSahaIsim;
    data['ozel_oyun'] = ozelOyun;
    data['ksha'] = ksha;
    data['ksha_1'] = ksha1;

    return data;
  }
}
