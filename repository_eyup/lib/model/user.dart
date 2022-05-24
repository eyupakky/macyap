class User {
  bool? success;
  int? userId;
  String? username;
  String? firstname;
  String? lastname;
  int? realibility;
  int? followers;
  int? following;
  int? manofthematch;
  String? image;
  bool? blocked;

  User(
      {this.success,
        this.userId,
        this.username,
        this.firstname,
        this.lastname,
        this.realibility,
        this.followers,
        this.following,
        this.manofthematch,
        this.image,this.blocked});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userId = json['user_id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    realibility = json['realibility'];
    followers = json['followers'];
    following = json['following'];
    manofthematch = json['manofthematch'];
    image = json['image'];
    blocked = json['blocked'] ?? false;
  }

}