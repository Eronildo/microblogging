import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/post_model.dart';

abstract class PostsDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> addPost(Post post);
  Future<PostModel> editPost(Post post);
  Future<bool> deletePost(Post post);
}
