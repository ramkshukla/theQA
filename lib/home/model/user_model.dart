import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imgUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  factory UserModel.initial() => UserModel(
        uid: "",
        name: "",
        email: "",
        imgUrl: "",
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      imgUrl: json["image"] ?? "",
    );
  }

  Map<String, String> toJson() {
    return <String, String>{
      "id": uid,
      "name": name,
      "email": email,
      "image": imgUrl,
    };
  }
}
