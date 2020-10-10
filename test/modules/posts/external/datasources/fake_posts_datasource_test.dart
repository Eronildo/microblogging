import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/posts/domain/entities/message.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/external/datasources/fake_posts_datasource.dart';

main() {
  final datasource = FakePostsDataSource(database: FakePostsDatabase());

  final loggedUser =
      User(email: "eronildoj@gmail.com", name: "Eronildo", photo: "");
  final postMessage = Message(content: "Test", createdDate: DateTime.now());
  final post = Post(user: loggedUser, message: postMessage);

  test('Should return a list of posts with three items', () async {
    final posts = await datasource.getPosts();
    expect(posts.length, 3);
  });

  test('Should post a message', () async {
    expect(datasource.addPost(post), completes);
  });

  test('Should edit a post message', () async {
    expect(datasource.editPost(post), completes);
  });

  test('Should delete a post', () async {
    expect(datasource.deletePost(post), completes);
  });
}
