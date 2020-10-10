import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/logout.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

main() {
  final repository = AuthRepositoryMock();
  final usecase = LogoutImpl(repository: repository);

  test('Should logout', () async {
    when(repository.logout()).thenAnswer((_) async => Right(unit));
    final result = await usecase();
    expect(result, Right(unit));
  });

  test('Should return LogoutError', () async {
    when(repository.logout()).thenAnswer((_) async => Left(LogoutError()));
    final result = await usecase();
    expect(result.fold(id, id), isA<LogoutError>());
  });
}
