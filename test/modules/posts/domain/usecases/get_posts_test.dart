import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/domain/usecases/sort_posts_chronologically.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/get_posts.dart';
import 'package:mockito/mockito.dart';

class PostsRepositoryMock extends Mock implements PostsRepository {}

class ConnectionServiceMock extends Mock implements ConnectionService {}

main() {
  final repository = PostsRepositoryMock();
  final connectionService = ConnectionServiceMock();
  final usecase = GetPostsImpl(
      repository: repository,
      connectionService: connectionService,
      sortPostsChronologically: SortPostsChronologicallyImpl());

  setUpAll(() {
    when(connectionService.isOnline()).thenAnswer((_) async => Right(unit));
  });

  test('Should return a list of posts', () async {
    when(repository.getPosts()).thenAnswer((_) async => Right(<Post>[]));
    expect(usecase(), completes);
  });

  test('Should return a GetPostsError', () async {
    when(repository.getPosts()).thenAnswer((_) async => Left(GetPostsError()));
    final result = await usecase();
    expect(result.leftMap((l) => l is GetPostsError), Left(true));
  });

  test('Should return a ConnectionError when is offline', () async {
    when(connectionService.isOnline())
        .thenAnswer((_) async => Left(ConnectionError()));
    final result = await usecase();
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
