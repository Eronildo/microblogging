import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/core/domain/services/local_storage_service.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/posts/domain/entities/message.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/delete_post.dart';
import 'package:mockito/mockito.dart';

class PostsRepositoryMock extends Mock implements PostsRepository {}

class ConnectionServiceMock extends Mock implements ConnectionService {}

class LocalStorageServiceMock extends Mock implements LocalStorageService {}

main() {
  final repository = PostsRepositoryMock();
  final connectionService = ConnectionServiceMock();
  final localStorageService = LocalStorageServiceMock();
  final usecase = DeletePostImpl(
      repository: repository,
      connectionService: connectionService,
      localStorageService: localStorageService);

  final userLogged =
      User(email: "eronildoj@gmail.com", name: "Eronildo", photo: "photo");

  setUpAll(() {
    when(connectionService.isOnline()).thenAnswer((_) async => Right(unit));
    when(localStorageService.getLoggedUser())
        .thenAnswer((_) => Right(userLogged));
  });

  test('Should delete a post', () async {
    final message = Message(content: "Test Post", createdDate: DateTime.now());
    final post = Post(user: userLogged, message: message);
    when(repository.deletePost(post)).thenAnswer((_) async => Right(true));
    expect(usecase(post), completes);
  });

  test('Should return a DeletePostError', () async {
    when(repository.deletePost(any))
        .thenAnswer((_) async => Left(DeletePostError()));
    final result = await usecase(Post());
    expect(result.leftMap((l) => l is DeletePostError), Left(true));
  });

  test('Should return a DeletePostError when is not post owner', () async {
    final user = User(email: "other@gmail.com", name: "Other", photo: "photo");
    final message =
        Message(content: "Test Not Owner", createdDate: DateTime.now());
    final post = Post(user: user, message: message);
    final result = await usecase(post);
    expect(result.leftMap((l) => l is DeletePostError), Left(true));
  });

  test('Should return a ConnectionError when is offline', () async {
    when(connectionService.isOnline())
        .thenAnswer((_) async => Left(ConnectionError()));
    final result = await usecase(Post());
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
