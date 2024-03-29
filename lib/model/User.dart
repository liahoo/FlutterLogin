class UserProfile {
  final int uid;
  final String email;
  final String lastName;
  final String firstName;
  final String city;
  final int gender;
  final String imagePath;
  final String bio;

  UserProfile.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email=json["email"],
        lastName = json["lastName"],
        firstName = json["firstName"],
        city = json["city"],
        gender = json["gender"],
        imagePath=json["imagePath"],
        bio=json["bio"];
}