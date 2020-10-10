import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';

abstract class Logout {
  Future<Either<Failure, Unit>> call();
}

class LogoutImpl implements Logout {
  final AuthRepository repository;

  LogoutImpl({@required this.repository});

  @override
  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}
