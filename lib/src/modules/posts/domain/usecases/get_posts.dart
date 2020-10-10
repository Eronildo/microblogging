import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/domain/usecases/sort_posts_chronologically.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';

abstract class GetPosts {
  Future<Either<Failure, List<Post>>> call();
}

class GetPostsImpl implements GetPosts {
  final PostsRepository repository;
  final ConnectionService connectionService;
  final SortPostsChronologically sortPostsChronologically;

  GetPostsImpl(
      {@required this.repository,
      @required this.connectionService,
      @required this.sortPostsChronologically});

  @override
  Future<Either<Failure, List<Post>>> call() async {
    final connectionResult = await connectionService.isOnline();

    if (connectionResult.isLeft()) {
      return connectionResult.map((r) => null);
    }

    return await _postsOrderedInChronologicalOrder;
  }

  Future<Either<Failure, List<Post>>>
      get _postsOrderedInChronologicalOrder async {
    final result = await repository.getPosts();
    return result
      ..map((r) {
        sortPostsChronologically(r);
      });
  }
}
