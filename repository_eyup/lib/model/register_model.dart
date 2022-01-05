class RegisterModel {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? tel;
  int? city;
  int? county;
  String? date;
  String? username;
  int? gender;
  String? neighborhood;

  RegisterModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.tel,
      this.city,
      this.county,
      this.date,
      this.username,
      this.gender,
      this.neighborhood});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    tel = json['tel'];
    city = json['city'];
    county = json['county'];
    date = json['date'];
    username = json['username'];
    gender = json['gender'];
    neighborhood = json['neighborhood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['password'] = password;
    data['tel'] = tel;
    data['city'] = city;
    data['county'] = county;
    data['date'] = date;
    data['username'] = username;
    data['gender'] = gender;
    data['neighborhood'] = neighborhood;
    return data;
  }
}
