import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';
import 'package:microblogging/src/modules/posts/infrastructure/datasources/posts_datasource.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/post_model.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDataSource dataSource;

  PostsRepositoryImpl({@required this.dataSource});

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      final posts = await dataSource.getPosts();
      return Right(posts);
    } catch (e) {
      return Left(GetPostsError(message: "Error trying get posts"));
    }
  }

  @override
  Future<Either<Failure, Post>> addPost(Post post) async {
    try {
      final postAdded = await dataSource.addPost(post);
      return Right(postAdded);
    } catch (e) {
      return Left(AddPostError(message: "Error trying add post"));
    }
  }

  @override
  Future<Either<Failure, Post>> editPost(Post post) async {
    try {
      final postEdited = await dataSource.editPost(post);
      return Right(postEdited);
    } catch (e) {
      return Left(EditPostError(message: "Error trying edit post"));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost(Post post) async {
    try {
      final result = await dataSource.deletePost(post);
      return Right(result);
    } catch (e) {
      return Left(DeletePostError(message: "Error trying delete post"));
    }
  }
}
