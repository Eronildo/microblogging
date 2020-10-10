import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/news/domain/errors/news_errors.dart';
import 'package:microblogging/src/modules/news/infrastructure/datasources/news_datasource.dart';
import 'package:microblogging/src/modules/news/infrastructure/models/news_model.dart';
import 'package:microblogging/src/modules/news/infrastructure/repositories/news_repository_impl.dart';
import 'package:mockito/mockito.dart';

class NewsDataSourceMock extends Mock implements NewsDataSource {}

main() {
  final datasource = NewsDataSourceMock();
  final repository = NewsRepositoryImpl(datasource: datasource);

  test('Should return latest news', () async {
    final news = NewsModel();
    when(datasource.getLatestNews()).thenAnswer((_) async => news);
    final result = await repository.getLatestNews();
    expect(result, Right(news));
  });

  test('Should throw a GetLatestNewsError', () async {
    when(datasource.getLatestNews()).thenThrow(GetLatestNewsError());
    final result = await repository.getLatestNews();
    expect(result.leftMap((l) => l is GetLatestNewsError), Left(true));
  });
}
