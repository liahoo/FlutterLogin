class User {
  final String name;
  final String email;
  final String gender;
  final String avatar;
  User(this.name, this.gender, this.email, this.avatar);

  User.fromJson(Map<String, dynamic> json) :
    gender = json["gender"],
    email=json["email"],
    avatar=json["avatar"],
    name=json["name"];
}