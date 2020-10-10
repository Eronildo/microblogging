import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/domain/erros/app_errors.dart';
import 'package:microblogging/src/core/domain/services/connection_service.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/posts/domain/entities/message.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/domain/repositories/posts_repository.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/add_post.dart';
import 'package:mockito/mockito.dart';

class PostsRepositoryMock extends Mock implements PostsRepository {}

class ConnectionServiceMock extends Mock implements ConnectionService {}

main() {
  final repository = PostsRepositoryMock();
  final connectionService = ConnectionServiceMock();
  final usecase =
      AddPostImpl(repository: repository, connectionService: connectionService);

  setUpAll(() {
    when(connectionService.isOnline()).thenAnswer((_) async => Right(unit));
  });

  test('Should add a post', () async {
    final userLogged =
        User(email: "eronildoj@gmail.com", name: "Eronildo", photo: "photo");
    final message = Message(content: "Test Post", createdDate: DateTime.now());
    final post = Post(user: userLogged, message: message);
    when(repository.addPost(post)).thenAnswer((_) async => Right(post));
    expect(usecase(post), completes);
  });

  test('Should return a AddPostError', () async {
    when(repository.addPost(any)).thenAnswer((_) async => Left(AddPostError()));
    final result = await usecase(Post());
    expect(result.leftMap((l) => l is AddPostError), Left(true));
  });

  test('Should return a AddPostError when post content is invalid', () async {
    final userLogged =
        User(email: "eronildoj@gmail.com", name: "Eronildo", photo: "photo");
    final message = Message(content: "", createdDate: DateTime.now());
    final post = Post(user: userLogged, message: message);
    final result = await usecase(post);
    expect(result.leftMap((l) => l is AddPostError), Left(true));
  });

  test('Should return a ConnectionError when is offline', () async {
    when(connectionService.isOnline())
        .thenAnswer((_) async => Left(ConnectionError()));
    final result = await usecase(Post());
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
