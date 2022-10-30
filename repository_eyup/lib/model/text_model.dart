class TextModel {
  late bool success;
  late List<Turnuvalar> turnuvalar;
  late String text="";


  TextModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['turnuvalar'] != null) {
      turnuvalar = <Turnuvalar>[];
      json['turnuvalar'].forEach((v) {
        Turnuvalar t1 = Turnuvalar.fromJson(v);
        turnuvalar.add(t1);
        text=text + "   " + t1.title;
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['turnuvalar'] = turnuvalar.map((v) => v.toJson()).toList();
    return data;
  }
}

class Turnuvalar {
  late int id;
  late String title;
  late String date;

  Turnuvalar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] =title;
    data['date'] = date;
    return data;
  }
}
