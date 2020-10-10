import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:microblogging/src/core/local/drivers/get_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:microblogging/src/shared/utils/mocks/user_json.dart';
import 'package:mockito/mockito.dart';

class GetStorageMock extends Mock implements GetStorage {}

main() {
  final storage = GetStorageMock();
  final driver = GetStorageDriver(localStorage: storage);

  test('Should return a Logged User', () {
    when(storage.read(any)).thenAnswer((_) => USER_JSON);
    final loggedUser = driver.getLoggedUser();
    expect(loggedUser.name, 'Eronildo Junior');
  });

  test('Should set a Logged User', () async {
    when(storage.write(any, any)).thenAnswer((_) async => unit);
    final future = driver.setLoggedUser(UserModel(
        name: 'Eronildo Junior', email: 'eronildoj@gmail.com', photo: ''));
    expect(future, completes);
  });

  test('Should remove a Logged User', () async {
    when(storage.remove(any)).thenAnswer((_) async => unit);
    final future = driver.removeLoggedUser();
    expect(future, completes);
  });

  test('Should return a GetStorage instance', () {
    final storage = driver.getStorage();
    expect(storage, isA<GetStorage>());
  });
}
