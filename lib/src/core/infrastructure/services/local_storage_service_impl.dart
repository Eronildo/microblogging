import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/local_storage_service.dart';
import 'package:microblogging/src/core/infrastructure/drivers/local_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final LocalStorageDriver driver;

  LocalStorageServiceImpl({@required this.driver});

  @override
  Either<Failure, User> getLoggedUser() {
    try {
      return Right(driver.getLoggedUser());
    } catch (e) {
      return Left(GetLoggedUserError(
        message: "Error trying get logged user",
      ));
    }
  }

  @override
  Future<Either<Failure, Unit>> setLoggedUser(User user) async {
    try {
      await driver.setLoggedUser(user);
      return Right(unit);
    } catch (e) {
      return Left(SetLoggedUserError(
        message: "Error trying set logged user",
      ));
    }
  }

  @override
  GetStorage getStorage() {
    return driver.getStorage();
  }
}
