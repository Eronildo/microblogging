import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/news/presenter/news_controller.dart';
import 'package:microblogging/src/modules/news/presenter/states/news_state.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/shared/widgets/bars/custom_app_bar.dart';
import 'package:microblogging/src/shared/widgets/posts/post_widget.dart';

class NewsPage extends GetView<NewsController> {
  static const String ROUTE_NAME = '/news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget,
      body: _bodyWidget,
    );
  }

  Widget get _appBarWidget => CustomAppBar(
        centerTitle: true,
        title: Text(
          'Latest News',
        ),
        elevation: 1.0,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: controller.loadNews)
        ],
      );

  Widget get _bodyWidget => RefreshIndicator(
        onRefresh: () async {
          await controller.loadNews(showLoading: false);
        },
        child: Center(
          child: Obx(() {
            final state = controller.state;

            if (state is LoadingNewsState) {
              return CircularProgressIndicator();
            } else if (state is ErrorNewsState) {
              return Text(
                  state.error.message ?? 'Error loading the latest news');
            } else if (state is EmptyNewsState) {
              return Text('No news found.');
            } else if (state is SuccessNewsState) {
              return _getNewsWidget(state.news.posts);
            }

            return Container();
          }),
        ),
      );

  Widget _getNewsWidget(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (_, index) {
        final post = posts[index];
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 10.0 : 0.0,
            bottom: posts.length - 1 == index ? 10.0 : 0.0,
          ),
          child: PostWidget(
            key: Key('${post.id}'),
            post: post,
            postPlaceHolderImageAssetPath: 'assets/images/logo.png',
          ),
        );
      },
    );
  }
}
