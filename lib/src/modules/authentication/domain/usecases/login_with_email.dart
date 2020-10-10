import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';

abstract class LoginWithEmail {
  Future<Either<Failure, User>> call(LoginCredential credential);
}

class LoginWithEmailImpl implements LoginWithEmail {
  final AuthRepository repository;
  final ConnectionService connectionService;

  LoginWithEmailImpl({
    @required this.repository,
    @required this.connectionService,
  });

  @override
  Future<Either<Failure, User>> call(LoginCredential credential) async {
    final connectionResult = await connectionService.isOnline();

    if (connectionResult.isLeft()) {
      return connectionResult.map((r) => null);
    }

    if (!credential.isValidEmail) {
      return Left(LoginWithEmailError(message: "Invalid Email"));
    } else if (!credential.isValidPassword) {
      return Left(LoginWithEmailError(message: "Invalid Password"));
    }

    final result = await repository.loginWithEmail(
        email: credential.email, password: credential.password);

    return result;
  }
}
