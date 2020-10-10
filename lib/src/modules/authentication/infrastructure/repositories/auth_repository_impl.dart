import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({@required this.dataSource});

  @override
  Future<Either<Failure, User>> loginWithEmail(
      {String email, String password}) async {
    try {
      final user =
          await dataSource.loginWithEmail(email: email, password: password);
      return Right(user);
    } on LoginWithEmailError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoginWithEmailError(
          message: "Error when trying to login with email"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await dataSource.logout();
      return Right(unit);
    } catch (e) {
      return Left(LogoutError(message: "Error when trying to logout"));
    }
  }

  @override
  Future<Either<Failure, User>> signupWithEmail(
      {String email, String password, String name}) async {
    try {
      final user = await dataSource.signupWithEmail(
          email: email, password: password, name: name);
      return Right(user);
    } catch (e) {
      return Left(SignupWithEmailError(
          message: "Error when trying to signup with email"));
    }
  }
}
