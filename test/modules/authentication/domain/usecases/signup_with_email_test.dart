import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/signup_with_email.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

class ConnectionServiceMock extends Mock implements ConnectionService {}

main() {
  final repository = AuthRepositoryMock();
  final connectionService = ConnectionServiceMock();
  final usecase = SignupWithEmailImpl(
      repository: repository, connectionService: connectionService);

  setUpAll(() {
    when(connectionService.isOnline()).thenAnswer((_) async => Right(unit));
  });

  test('Should return a UserInfo', () async {
    final userInfo = User(email: '', name: '');
    when(repository.signupWithEmail(
            email: anyNamed('email'),
            password: anyNamed('password'),
            name: anyNamed('name')))
        .thenAnswer((_) async => Right(userInfo));
    final result = await usecase.call(
        LoginCredential.withEmailAndPasswordAndName(
            email: "eronildoj@gmail.com",
            password: "123456",
            name: "Eronildo Junior"));
    expect(result, Right(userInfo));
  });

  test('Should return a SignupWithEmailError when email is invalid', () async {
    final result = await usecase.call(
        LoginCredential.withEmailAndPasswordAndName(
            email: "eronildoj@", password: "123456", name: "Eronildo Junior"));
    expect(result.fold(id, id), isA<SignupWithEmailError>());
  });

  test('Should return a SignupWithEmailError when password is invalid',
      () async {
    final result = await usecase.call(
        LoginCredential.withEmailAndPasswordAndName(
            email: "eronildoj@gmail.com",
            password: "123",
            name: "Eronildo Junior"));
    expect(result.fold(id, id), isA<SignupWithEmailError>());
  });

  test('Should return a SignupWithEmailError when name is invalid', () async {
    final result = await usecase.call(
        LoginCredential.withEmailAndPasswordAndName(
            email: "eronildoj@gmail.com", password: "123456", name: "Er"));
    expect(result.fold(id, id), isA<SignupWithEmailError>());
  });
}
