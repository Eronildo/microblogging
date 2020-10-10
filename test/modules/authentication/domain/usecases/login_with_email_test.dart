import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/login_with_email.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements AuthRepository {}

class ConnectionServiceMock extends Mock implements ConnectionService {}

main() {
  final repository = LoginRepositoryMock();
  final connectionService = ConnectionServiceMock();
  final usecase = LoginWithEmailImpl(
      repository: repository, connectionService: connectionService);

  setUpAll(() {
    when(connectionService.isOnline()).thenAnswer((_) async => Right(unit));
  });

  test('Should login with email return UserInfo', () async {
    final userInfo = User(email: "", name: "");
    when(repository.loginWithEmail(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => Right(userInfo));
    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "eronildoj@gmail.com", password: "123456"));
    expect(result, Right(userInfo));
  });

  test('Should verify if email is invalid', () async {
    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "eronildoj@", password: "123456"));
    expect(result.leftMap((l) => l is LoginWithEmailError), Left(true));
  });

  test('Should verify if password is invalid', () async {
    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "eronildoj@gmail.com", password: "123"));
    expect(result.leftMap((l) => l is LoginWithEmailError), Left(true));
  });

  test('Should return a ConnectionError because is offline', () async {
    when(connectionService.isOnline())
        .thenAnswer((_) async => Left(ConnectionError()));
    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "eronildoj@gmail.com", password: "123"));
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
