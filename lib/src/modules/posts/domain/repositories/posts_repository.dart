import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post>> addPost(Post post);
  Future<Either<Failure, Post>> editPost(Post post);
  Future<Either<Failure, bool>> deletePost(Post post);
}
