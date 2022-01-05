class MatchesModel{
  late String title;

  MatchesModel({required this.title});

  MatchesModel.fromJson(Map map){
    title = map["title"];
  }
}