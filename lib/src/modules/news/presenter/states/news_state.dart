import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/news/domain/entities/news.dart';

abstract class NewsState {}

class LoadingNewsState implements NewsState {}

class EmptyNewsState implements NewsState {}

class SuccessNewsState implements NewsState {
  final News news;
  const SuccessNewsState(this.news);
}

class ErrorNewsState implements NewsState {
  final Failure error;
  const ErrorNewsState(this.error);
}
