import 'package:microblogging/src/core/domain/erros/app_errors.dart';

class GetPostsError extends Failure {
  final String message;
  GetPostsError({this.message});
}

class AddPostError extends Failure {
  final String message;
  AddPostError({this.message});
}

class EditPostError extends Failure {
  final String message;
  EditPostError({this.message});
}

class DeletePostError extends Failure {
  final String message;
  DeletePostError({this.message});
}
