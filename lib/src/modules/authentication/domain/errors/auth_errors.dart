import 'package:microblogging/src/core/domain/erros/app_errors.dart';

class LoginWithEmailError extends Failure {
  final String message;
  LoginWithEmailError({this.message});
}

class LogoutError extends Failure {
  final String message;
  LogoutError({this.message});
}

class SignupWithEmailError extends Failure {
  final String message;
  SignupWithEmailError({this.message});
}
