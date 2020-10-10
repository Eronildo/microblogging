import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/posts_controller.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/states/posts_state.dart';
import 'package:microblogging/src/shared/widgets/posts/post_widget.dart';

class PostsPage extends GetView<PostsController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.loadPosts(showLoading: false);
      },
      child: Center(
        child: Obx(
              () {
            final state = controller.state;

            if (state is LoadingPostsState) {
              return CircularProgressIndicator();
            } else if (state is ErrorPostsState) {
              return _getErrorWidget(state.error.message);
            } else if (state is SuccessPostsState) {
              return _getPostsWidget(controller.posts);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _getErrorWidget(String errorMessage) =>
      _getMessageWidget(errorMessage ?? 'Error loading the posts');

  Widget get _emptyWidget => _getMessageWidget('No posts found.');

  Widget _getMessageWidget(String message) => ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.4),
            child: Center(child: Text(message)),
          ),
        ],
      );

  Widget _getPostsWidget(List<Post> posts) {
    if (posts.isEmpty) return _emptyWidget;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (_, index) {
        final post = posts[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: posts.length - 1 == index ? Get.height * 0.12 : 0.0,
          ),
          child: PostWidget(
            key: Key('${post.id}'),
            post: post,
            options: controller.getPostOptions(post, index),
          ),
        );
      },
    );
  }
}
