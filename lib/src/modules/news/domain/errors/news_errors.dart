import 'package:microblogging/src/core/domain/erros/app_errors.dart';

class GetLatestNewsError extends Failure {
  final String message;

  GetLatestNewsError({this.message});
}
