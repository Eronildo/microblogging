import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_database.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_datasource.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:mockito/mockito.dart';

class FakeDatabaseMock extends Mock implements FakeDatabase {}

main() {
  final database = FakeDatabaseMock();
  final datasource = FakeDataSourceImpl(database: database);

  final userResult = {'email': 'eronildoj@gmail.com', 'name': 'Eronildo'};

  test('Should return a UserModel when login with email', () async {
    when(database.signin(any, any)).thenAnswer((_) async => userResult);
    final result = await datasource.loginWithEmail();
    expect(result, isA<UserModel>());
  });

  test('Should try login with not existing user', () {
    when(database.signin(any, any)).thenThrow(LoginWithEmailError());
    expect(datasource.loginWithEmail(), throwsA(isA<LoginWithEmailError>()));
  });

  test('Should logout', () {
    when(database.logout()).thenAnswer((_) async {});
    expect(datasource.logout(), completes);
  });

  test('Should return a UserModel when signup with email', () async {
    when(database.signup(any, any, any)).thenAnswer((_) async => userResult);
    final result = await datasource.signupWithEmail();
    expect(result, isA<UserModel>());
  });
}
