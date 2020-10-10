import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/app/app_service.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/delete_post.dart';

import 'package:microblogging/src/modules/posts/domain/usecases/get_posts.dart';
import 'package:microblogging/src/modules/posts/presenter/add_post/add_post_page.dart';
import 'package:microblogging/src/modules/posts/presenter/edit_post/edit_post_page.dart';
import 'package:microblogging/src/modules/posts/presenter/entities/post_option.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/states/posts_state.dart';
import 'package:microblogging/src/shared/widgets/dialogs/custom_dialog.dart';

class PostsController extends GetxController {
  final GetPosts getPosts;
  final DeletePost deletePost;

  final _loggedUserEmail = Get.find<AppService>().loggedUser.email;
  final _state = Rx<PostsState>();
  final posts = <Post>[].obs;

  PostsController({@required this.getPosts, @required this.deletePost});

  PostsState get state => _state.value;
  set state(value) => _state.value = value;

  @override
  void onInit() async {
    await loadPosts();
    super.onInit();
  }

  Future<void> loadPosts({bool showLoading = true}) async {
    if (showLoading) state = LoadingPostsState();
    final result = await getPosts();
    result.fold(
      (l) {
        Get.rawSnackbar(message: l.message);
        state = ErrorPostsState(l);
      },
      (r) {
        posts.assignAll(r);
        state = SuccessPostsState();
      },
    );
  }

  void _addPostOnTop(Post post) {
    posts.insert(0, post);
  }

  void _notifyPostShared() {
    Get.rawSnackbar(
      message: 'Your post was shared.',
    );
  }

  List<PostOption> getPostOptions(Post post, int postIndex) {
    return post.isPostOwner(_loggedUserEmail)
        ? [
            PostOption(
              onPressed: () {
                goToEditPostPage(post, postIndex);
              },
              name: 'Edit Post',
              iconData: Icons.edit_outlined,
            ),
            PostOption(
              onPressed: () {
                removePost(post);
              },
              name: 'Delete Post',
              iconData: Icons.delete_outline,
            )
          ]
        : [];
  }

  void goToAddPostPage() {
    Get.toNamed(AddPostPage.ROUTE_NAME).then((value) {
      if (value != null && value is Post) {
        _addPostOnTop(value);
        _notifyPostShared();
      }
    });
  }

  void goToEditPostPage(Post post, int postIndex) {
    Get.toNamed(EditPostPage.ROUTE_NAME, arguments: post).then((value) {
      if (value != null && value is Post) {
        post.message.content = value.message.content;

        posts.remove(post);
        posts.insert(postIndex, value);

        _notifyPostShared();
      }
    });
  }

  void removePost(Post post) {
    Get.dialog(CustomDialog(
      contentText: 'Are you sure you want to delete this post?',
      confirmText: 'DELETE',
      onConfirmPressed: () async {
        final result = await deletePost(post);
        result.fold(
          (l) {
            Get.back();
            Get.rawSnackbar(message: "Post wasn't deleted: ${l.message}");
          },
          (r) {
            posts.remove(post);
            Get.back();
          },
        );
      },
    ));
  }
}
