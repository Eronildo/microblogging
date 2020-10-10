import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';

abstract class LocalStorageService {
  Either<Failure, User> getLoggedUser();
  Future<Either<Failure, Unit>> setLoggedUser(User user);
  GetStorage getStorage();
}
