class VenusModel {
  bool? success;
  List<Venues>? venues;

  VenusModel({this.success, this.venues});

  VenusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['venues'] != null) {
      venues = <Venues>[];
      json['venues'].forEach((v) {
        venues!.add(Venues.fromJson(v));
      });
    }
  }
}

class Venues {
  int? id;
  String? name;
  String? address;
  String? description;
  String? locationX;
  String? locationY;
  String? il;
  String? ilce;
  String? image;

  Venues(
      {this.id,
      this.name,
      this.address,
      this.description,
      this.locationX,
      this.locationY,
      this.il,
      this.ilce,
      this.image});

  Venues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    locationX = json['location_x'];
    locationY = json['location_y'];
    il = json['il'];
    ilce = json['ilce'];
    image = json['image'];
  }
}
