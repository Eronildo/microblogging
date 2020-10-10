import 'package:microblogging/src/core/domain/erros/app_errors.dart';

abstract class PostsState {}

class LoadingPostsState implements PostsState {}

class SuccessPostsState implements PostsState {}

class ErrorPostsState implements PostsState {
  final Failure error;
  const ErrorPostsState(this.error);
}
