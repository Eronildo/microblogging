import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/infrastructure/drivers/connection_driver.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:mockito/mockito.dart';

class ConnectionDriverMock extends Mock implements ConnectionDriver {}

main() {
  final driver = ConnectionDriverMock();
  final service = ConnectionServiceImpl(driver: driver);

  test('Should return is online true', () async {
    when(driver.isOnline).thenAnswer((_) async => true);
    final result = await service.isOnline();
    expect(result, isA<Right<Failure, Unit>>());
  });

  test('Should throw a ConnectionError', () async {
    when(driver.isOnline).thenThrow(ConnectionError());
    final result = await service.isOnline();
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
