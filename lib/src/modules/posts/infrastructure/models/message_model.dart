import 'dart:convert';

import 'package:microblogging/src/modules/posts/domain/entities/message.dart';

class MessageModel extends Message {
  final String content;
  final DateTime createdDate;

  MessageModel({this.content, this.createdDate});

  factory MessageModel.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;

    return MessageModel(
      content: json['content'],
      createdDate: DateTime.tryParse(json['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'created_at': createdDate.toString(),
    };
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}
