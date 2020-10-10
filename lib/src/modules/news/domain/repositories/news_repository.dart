import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/news/domain/entities/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, News>> getLatestNews();
}
