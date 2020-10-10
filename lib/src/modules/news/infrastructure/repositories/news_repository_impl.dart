import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/news/domain/entities/news.dart';
import 'package:microblogging/src/modules/news/domain/errors/news_errors.dart';
import 'package:microblogging/src/modules/news/domain/repositories/news_repository.dart';
import 'package:microblogging/src/modules/news/infrastructure/datasources/news_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource datasource;

  NewsRepositoryImpl({@required this.datasource});

  @override
  Future<Either<Failure, News>> getLatestNews() async {
    try {
      final news = await datasource.getLatestNews();
      return Right(news);
    } catch (e) {
      return Left(
          GetLatestNewsError(message: "Error when trying get latest news"));
    }
  }
}
