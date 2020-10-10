import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/domain/services/local_storage_service.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';

abstract class DeletePost {
  Future<Either<Failure, bool>> call(Post post);
}

class DeletePostImpl implements DeletePost {
  final PostsRepository repository;
  final ConnectionService connectionService;
  final LocalStorageService localStorageService;

  DeletePostImpl(
      {@required this.repository,
      @required this.connectionService,
      @required this.localStorageService});

  @override
  Future<Either<Failure, bool>> call(Post post) async {
    final connectionResult = await connectionService.isOnline();

    if (connectionResult.isLeft()) {
      return connectionResult.map((r) => null);
    }

    final storageResult = localStorageService.getLoggedUser();

    if (storageResult.isLeft()) {
      return storageResult.map((r) => null);
    }

    if (post != null) {
      final user = storageResult.fold((l) => null, (r) => r);
      if (!post.isPostOwner(user.email)) {
        return Left(
            DeletePostError(message: "You're not the owner of this post"));
      }
    } else {
      return Left(DeletePostError(message: "Invalid post"));
    }

    return await repository.deletePost(post);
  }
}
