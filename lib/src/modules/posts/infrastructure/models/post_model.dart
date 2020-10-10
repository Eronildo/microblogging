import 'dart:convert';

import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/message_model.dart';

class PostModel extends Post {
  final UserModel user;
  final MessageModel message;

  PostModel({this.user, this.message});

  factory PostModel.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;

    return PostModel(
      user: UserModel.fromMap(json['user']),
      message: MessageModel.fromMap(json['message']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'message': message.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}
