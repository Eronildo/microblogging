import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/infrastructure/services/local_storage_service_impl.dart';
import 'package:microblogging/src/core/local/drivers/get_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:mockito/mockito.dart';

class GetStorageDriverMock extends Mock implements GetStorageDriver {}

main() {
  final driver = GetStorageDriverMock();
  final service = LocalStorageServiceImpl(driver: driver);

  test('Should return a Logged User', () {
    when(driver.getLoggedUser()).thenAnswer((_) => UserModel());
    final result = service.getLoggedUser();
    expect(result, isA<Right<Failure, User>>());
  });

  test('Should return a no user', () {
    when(driver.getLoggedUser()).thenAnswer((_) => null);
    final result = service.getLoggedUser();
    expect(result.map((r) => r is User), Right(false));
  });

  test('Should throw a Exception when try to get a Logged User', () {
    when(driver.getLoggedUser()).thenThrow(Exception());
    final result = service.getLoggedUser();
    expect(result.leftMap((l) => l is GetLoggedUserError), Left(true));
  });

  test('Should set a Logged User', () {
    when(driver.setLoggedUser(any)).thenAnswer((_) async => unit);
    final future = service.setLoggedUser(
        User(name: 'Eronildo Junior', email: 'eronildoj@gmail.com', photo: ''));
    expect(future, completes);
  });

  test('Should throw a exception when try to set a Logged User', () async {
    when(driver.setLoggedUser(any)).thenThrow(Exception());
    final result = await service.setLoggedUser(
        User(name: 'Eronildo Junior', email: 'eronildoj@gmail.com', photo: ''));
    expect(result.leftMap((l) => l is SetLoggedUserError), Left(true));
  });
}
