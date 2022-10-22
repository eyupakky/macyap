class MatchesModel {
  bool? success;
  List<Match>? match;

  MatchesModel({this.success, this.match});

  MatchesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      match = <Match>[];
      json['value'].forEach((v) {
        match!.add(Match.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (match != null) {
      data['match'] = match!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Match {
  int? gameId;
  String? title;
  List<String>? tagler;
  double? gamePrice;
  int? limit;
  String? date;
  String? name;
  String? username;
  String? image;
  int? joinedGamers;
  String? gameType;
  String? ilce;
  Match(
      {this.gameId,
      this.title,
      this.tagler,
      this.gamePrice,
      this.limit,
      this.date,
      this.name,
      this.username,
      this.image,
      this.joinedGamers,this.gameType,this.ilce});

  Match.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    title = json['title'];
    tagler = [];
    if (json['tagler'] != null && json['tagler'] != "") {
      tagler = json['tagler'].split(" ");
    }
    if(json["il"]!=null){
      tagler!.add(json["il"]);
    }
    if(json["ilce"]!=null){
      ilce=json["ilce"].replaceAll("#", "");
    }
    if(json["cinsiyet"]!=null){
      tagler!.add(json["cinsiyet"]);
    }
    gamePrice = json['game_price'];
    if(gamePrice==0){
      tagler!.add("#ÜCRETSİZ");
    }
    limit = json['limit'];
    date = json['date'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
    joinedGamers = json['joined_gamers'];
    gameType = json['game_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_id'] = gameId;
    data['title'] = title;
    data['tagler'] = tagler;
    data['game_price'] = gamePrice;
    data['limit'] = limit;
    data['date'] = date;
    data['name'] = name;
    data['username'] = username;
    data['image'] = image;
    data['joined_gamers'] = joinedGamers;
    return data;
  }
}
