class VenusModel{
  late String title;

  VenusModel({required this.title});

  VenusModel.fromJson(Map map){
    title = map["title"];
  }
}