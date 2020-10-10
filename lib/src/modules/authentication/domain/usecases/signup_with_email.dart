import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';

abstract class SignupWithEmail {
  Future<Either<Failure, User>> call(LoginCredential credential);
}

class SignupWithEmailImpl implements SignupWithEmail {
  final AuthRepository repository;
  final ConnectionService connectionService;

  SignupWithEmailImpl(
      {@required this.repository, @required this.connectionService});

  @override
  Future<Either<Failure, User>> call(LoginCredential credential) async {
    final connectionResult = await connectionService.isOnline();
    if (connectionResult.isLeft()) {
      return connectionResult.map((r) => null);
    }

    if (!credential.isValidEmail) {
      return Left(SignupWithEmailError(message: "Invalid Email"));
    } else if (!credential.isValidPassword) {
      return Left(SignupWithEmailError(message: "Invalid Password"));
    } else if (!credential.isValidName) {
      return Left(SignupWithEmailError(message: "Invalid Name"));
    }

    return await repository.signupWithEmail(
        email: credential.email,
        password: credential.password,
        name: credential.name);
  }
}
