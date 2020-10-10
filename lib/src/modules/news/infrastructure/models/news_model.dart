import 'package:microblogging/src/modules/news/domain/entities/news.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/post_model.dart';

class NewsModel extends News {
  final List<PostModel> posts;

  NewsModel({this.posts});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return NewsModel(
      posts:
          List<PostModel>.from(json['news']?.map((x) => PostModel.fromMap(x))),
    );
  }
}
