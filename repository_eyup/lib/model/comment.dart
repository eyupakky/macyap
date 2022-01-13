class Comment {
  bool? success;
  List<Comments>? comments;

  Comment({this.success, this.comments});

  Comment.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (comments != null) {
      data['value'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? userId;
  int? commentId;
  String? comment;
  String? username;
  String? favoritePosition;
  String? firstname;
  String? lastname;
  String? image;

  Comments(
      {this.userId,
        this.commentId,
        this.comment,
        this.username,
        this.favoritePosition,
        this.firstname,
        this.lastname,
        this.image});

  Comments.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    commentId = json['comment_id'];
    comment = json['comment'];
    username = json['username'];
    favoritePosition = json['favorite_position'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['comment_id'] = commentId;
    data['comment'] = comment;
    data['username'] = username;
    data['favorite_position'] = favoritePosition;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['image'] = image;
    return data;
  }
}