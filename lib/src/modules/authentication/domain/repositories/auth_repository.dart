import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmail({String email, String password});

  Future<Either<Failure, User>> signupWithEmail(
      {String email, String password, String name});

  Future<Either<Failure, Unit>> logout();
}
