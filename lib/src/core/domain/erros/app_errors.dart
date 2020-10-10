abstract class Failure implements Exception {
  String get message;
}

class ConnectionError extends Failure {
  final String message;
  ConnectionError({this.message});
}

class GetLoggedUserError extends Failure {
  final String message;
  GetLoggedUserError({this.message});
}

class SetLoggedUserError extends Failure {
  final String message;
  SetLoggedUserError({this.message});
}
