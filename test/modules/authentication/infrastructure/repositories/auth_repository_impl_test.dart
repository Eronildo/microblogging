import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/datasources/auth_datasource.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

class AuthDataSourceMock extends Mock implements AuthDataSource {}

main() {
  final datasource = AuthDataSourceMock();
  final repository = AuthRepositoryImpl(dataSource: datasource);

  final userResult = UserModel(name: "Eronildo", email: "eronildo@gmail.com");

  test('Should login with email', () async {
    when(datasource.loginWithEmail()).thenAnswer((_) async => userResult);
    final result = await repository.loginWithEmail();
    expect(result, isA<Right<Failure, User>>());
  });

  test('Should throw a LoginWithEmailError when user try login with email',
      () async {
    when(datasource.loginWithEmail()).thenThrow(LoginWithEmailError());
    final result = await repository.loginWithEmail();
    expect(result.leftMap((l) => l is LoginWithEmailError), Left(true));
  });

  test('Should logout', () async {
    when(datasource.logout()).thenAnswer((_) async {});
    final result = await repository.logout();
    expect(result, isA<Right<Failure, Unit>>());
  });

  test('Should throw LogoutError when user try logout', () async {
    when(datasource.logout()).thenThrow(LogoutError());
    final result = await repository.logout();
    expect(result.leftMap((l) => l is LogoutError), Left(true));
  });

  test('Should signup with email', () async {
    when(datasource.signupWithEmail()).thenAnswer((_) async => userResult);
    final result = await repository.signupWithEmail();
    expect(result, isA<Right<Failure, User>>());
  });

  test('Should throw a SignupWithEmailError when user try signup with email',
      () async {
    when(datasource.signupWithEmail()).thenThrow(SignupWithEmailError());
    final result = await repository.signupWithEmail();
    expect(result.leftMap((l) => l is SignupWithEmailError), Left(true));
  });
}
