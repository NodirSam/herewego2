class Post {
  int? id;
  String? firstName;
  String? lastName;
  String? content;
  String? date;
  //String? img_url;
  //int? userId;
  String? userId;

  Post({this.id, this.firstName, this.lastName, this.content, this.date, this.userId});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        content = json["content"],
        date = json["date"],
  //img_url = json['img_url'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'content' : content,
    'date' : date,
    //'img_url': img_url,
    'userId': userId,
  };
}