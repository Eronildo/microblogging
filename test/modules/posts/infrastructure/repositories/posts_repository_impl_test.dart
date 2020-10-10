import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/errors/posts_erros.dart';
import 'package:microblogging/src/modules/posts/infrastructure/datasources/posts_datasource.dart';
import 'package:microblogging/src/modules/posts/infrastructure/models/post_model.dart';
import 'package:microblogging/src/modules/posts/infrastructure/repositories/posts_repository_impl.dart';
import 'package:mockito/mockito.dart';

class PostsDataSourceMock extends Mock implements PostsDataSource {}

main() {
  final datasource = PostsDataSourceMock();
  final repository = PostsRepositoryImpl(dataSource: datasource);

  group('getPosts', () {
    test('Should return a list of posts', () async {
      when(datasource.getPosts()).thenAnswer((_) async => <PostModel>[]);
      expect(repository.getPosts(), completes);
    });

    test('Should return a GetPostsError', () async {
      when(datasource.getPosts()).thenThrow(GetPostsError());
      final result = await repository.getPosts();
      expect(result.leftMap((l) => l is GetPostsError), Left(true));
    });
  });

  group('addPost', () {
    test('Should add a post', () async {
      when(datasource.addPost(any)).thenAnswer((_) async => PostModel());
      expect(repository.addPost(Post()), completes);
    });

    test('Should return a AddPostError', () async {
      when(datasource.addPost(any)).thenThrow(AddPostError());
      final result = await repository.addPost(Post());
      expect(result.leftMap((l) => l is AddPostError), Left(true));
    });
  });

  group('editPost', () {
    test('Should edit a post', () async {
      when(datasource.editPost(any)).thenAnswer((_) async => PostModel());
      expect(repository.editPost(Post()), completes);
    });

    test('Should return a EditPostError', () async {
      when(datasource.editPost(any)).thenThrow(EditPostError());
      final result = await repository.editPost(Post());
      expect(result.leftMap((l) => l is EditPostError), Left(true));
    });
  });

  group('deletePost', () {
    test('Should delete a post', () async {
      when(datasource.deletePost(any)).thenAnswer((_) async => true);
      expect(repository.deletePost(Post()), completes);
    });

    test('Should return a DeletePostError', () async {
      when(datasource.deletePost(any)).thenThrow(DeletePostError());
      final result = await repository.deletePost(Post());
      expect(result.leftMap((l) => l is DeletePostError), Left(true));
    });
  });
}
