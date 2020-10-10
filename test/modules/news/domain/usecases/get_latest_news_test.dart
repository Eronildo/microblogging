import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/domain/usecases/sort_posts_chronologically.dart';
import 'package:microblogging/src/modules/news/domain/entities/news.dart';
import 'package:microblogging/src/modules/news/domain/errors/news_errors.dart';
import 'package:microblogging/src/modules/news/domain/repositories/news_repository.dart';
import 'package:microblogging/src/modules/news/domain/usecases/get_latest_news.dart';
import 'package:mockito/mockito.dart';

class NewsRepositoryMock extends Mock implements NewsRepository {}

class ConnectionServiceMock extends Mock implements ConnectionService {}

main() {
  final repository = NewsRepositoryMock();
  final connectionService = ConnectionServiceMock();
  final usecase = GetLatestNewsImpl(
      repository: repository,
      connectionService: connectionService,
      sortPostsChronologically: SortPostsChronologicallyImpl());

  setUpAll(() {
    when(connectionService.isOnline()).thenAnswer((_) async => Right(unit));
  });

  test('Should return latest news', () async {
    final news = News(posts: []);
    when(repository.getLatestNews()).thenAnswer((_) async => Right(news));
    final result = await usecase();
    expect(result, Right(news));
  });

  test('Should return GetLatestNewsError', () async {
    when(repository.getLatestNews())
        .thenAnswer((_) async => Left(GetLatestNewsError()));
    final result = await usecase();
    expect(result.leftMap((l) => l is GetLatestNewsError), Left(true));
  });

  test('Should return ConnectionError when is offline', () async {
    when(connectionService.isOnline())
        .thenAnswer((_) async => Left(ConnectionError()));
    final result = await usecase();
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
