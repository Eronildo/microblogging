import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/infrastructure/drivers/connection_driver.dart';

class ConnectionServiceImpl implements ConnectionService {
  final ConnectionDriver driver;

  ConnectionServiceImpl({@required this.driver});

  @override
  Future<Either<Failure, Unit>> isOnline() async {
    try {
      final isConnected = await driver.isOnline;
      if (isConnected) {
        return Right(unit);
      }
      throw ConnectionError(message: "You're offline");
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ConnectionError(message: "Connection Error"));
    }
  }
}
