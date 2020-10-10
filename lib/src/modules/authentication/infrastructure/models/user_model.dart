import 'dart:convert';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';

class UserModel extends User {
  final String email;
  final String name;
  final String photo;

  UserModel({this.email, this.name, this.photo = ''});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profile_picture': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      email: map['email'],
      name: map['name'],
      photo: map['profile_picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
