class GameUsers {
  bool? success;
  List<Users>? allTeam;
  List<Users>? myTeam;
  List<Users>? rivalTeam;
  int? myTeamSize = 0;
  int? rivalTeamSize = 0;
  int? totalPlayers = 14;
  int? totalCheckPlayers = 0;

  GameUsers();

  GameUsers.fromJson(Map<String, dynamic> json, int? limit) {
    int? teamSize = limit! ~/ 2;
    success = json['success'];
    if (json['users'] != null) {
      myTeam = <Users>[];
      rivalTeam = <Users>[];
      allTeam = <Users>[];
      json['users'].forEach((v) {
        Users users = Users.fromJson(v);
        allTeam!.add(users);
        if (users.team == "0") {
          rivalTeam!.add(users);
        } else {
          myTeam!.add(users);
        }
      });
      rivalTeamSize = rivalTeam!.length;
      if (rivalTeam!.length <= teamSize) {
        int temp = teamSize - rivalTeam!.length;
        for (int i = 0; i < temp; i++) {
          rivalTeam!.add(Users(
              userId: -1,
              image: "assets/images/thumb_avatar.jpeg",
              username: "Açık"));
        }
      }
      myTeamSize = myTeam!.length;
      if (myTeam!.length <= teamSize) {
        int temp = teamSize - myTeam!.length;
        for (int i = 0; i < temp; i++) {
          myTeam!.add(Users(
              userId: -1,
              image: "assets/images/thumb_avatar.jpeg",
              username: "Açık"));
        }
      }
      totalCheckPlayers = rivalTeamSize! + myTeamSize!;
      totalPlayers=myTeam!.length + rivalTeam!.length;
    }
  }
}

class Users {
  int? userId;
  String? username;
  String? favoritePosition;
  String? firstname;
  String? lastname;
  String? team;
  String? image;

  Users(
      {this.userId,
      this.username,
      this.favoritePosition,
      this.firstname,
      this.lastname,
      this.team,
      this.image});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    favoritePosition = json['favorite_position'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    team = json['team'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['favorite_position'] = favoritePosition;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['team'] = team;
    data['image'] = image;
    return data;
  }
}
