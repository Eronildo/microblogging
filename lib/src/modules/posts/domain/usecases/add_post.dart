import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';

abstract class AddPost {
  Future<Either<Failure, Post>> call(Post post);
}

class AddPostImpl implements AddPost {
  final PostsRepository repository;
  final ConnectionService connectionService;

  AddPostImpl({@required this.repository, @required this.connectionService});

  @override
  Future<Either<Failure, Post>> call(Post post) async {
    final connectionResult = await connectionService.isOnline();

    if (connectionResult.isLeft()) {
      return connectionResult.map((r) => null);
    }

    if (!post.isValidMessageContent) {
      return Left(AddPostError(message: "Invalid post content"));
    }

    return await repository.addPost(post);
  }
}
