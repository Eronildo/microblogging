import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/domain/usecases/sort_posts_chronologically.dart';
import 'package:microblogging/src/modules/news/domain/entities/news.dart';
import 'package:microblogging/src/modules/news/domain/repositories/news_repository.dart';

abstract class GetLatestNews {
  Future<Either<Failure, News>> call();
}

class GetLatestNewsImpl implements GetLatestNews {
  final NewsRepository repository;
  final ConnectionService connectionService;
  final SortPostsChronologically sortPostsChronologically;

  GetLatestNewsImpl(
      {@required this.repository,
      @required this.connectionService,
      @required this.sortPostsChronologically});

  @override
  Future<Either<Failure, News>> call() async {
    final connectionResult = await connectionService.isOnline();
    if (connectionResult.isLeft()) {
      return connectionResult.map((r) => null);
    }
    return await _postsOrderedInChronologicalOrder;
  }

  Future<Either<Failure, News>> get _postsOrderedInChronologicalOrder async {
    final result = await repository.getLatestNews();
    result.map((r) {
      sortPostsChronologically(r.posts);
      return r;
    });

    return result;
  }
}
