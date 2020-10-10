import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';

abstract class ConnectionService {
  Future<Either<Failure, Unit>> isOnline();
}
