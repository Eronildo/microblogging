import 'dart:convert';

import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/infrastructure/datasources/posts_datasource.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/message_model.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/post_model.dart';
import 'package:microblogging/src/shared/utils/mocks/posts_json.dart';
import 'package:meta/meta.dart';

class FakePostsDataSource implements PostsDataSource {
  final FakePostsDatabase database;

  FakePostsDataSource({@required this.database});

  @override
  Future<List<PostModel>> getPosts() async {
    return await database.getPosts();
  }

  @override
  Future<PostModel> addPost(Post post) async {
    return await database.addPost(post);
  }

  @override
  Future<PostModel> editPost(Post post) async {
    return await database.editPost(post);
  }

  @override
  Future<bool> deletePost(Post post) async {
    return await database.deletePost(post.id);
  }
}

class FakePostsDatabase {
  final int _delayedTimeInMilliseconds = 500;
  Post _post;

  Future<dynamic> _makeDelayed() async {
    await Future.delayed(Duration(milliseconds: _delayedTimeInMilliseconds));
  }

  PostModel _convertPostToPostModel() {
    return PostModel(
        user: UserModel(
        email: _post.user.email,
        name: _post.user.name,
        photo: _post.user.photo),
    message: MessageModel(
    content: _post.message.content,
    createdDate: _post.message.createdDate));
  }

  Future<PostModel> addPost(Post post) async {
    await _makeDelayed();
    _post = post;
    return _convertPostToPostModel();
  }

  Future<PostModel> editPost(Post post) async {
    await _makeDelayed();
    _post = post;
    return _convertPostToPostModel();
  }

  Future<List<PostModel>> getPosts() async {
    await _makeDelayed();
    final postsJson = json.decode(POSTS_JSON);
    return postsJson.map<PostModel>((json) => PostModel.fromMap(json)).toList();
  }

  Future<bool> deletePost(int postID) async {
    await _makeDelayed();
    return true;
  }
}
