import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/modules/news/domain/entities/news.dart';

import 'package:microblogging/src/modules/news/domain/usecases/get_latest_news.dart';
import 'package:microblogging/src/modules/news/presenter/states/news_state.dart';

class NewsController extends GetxController {
  final GetLatestNews getLatestNews;

  final _state = Rx<NewsState>();

  NewsController({@required this.getLatestNews});

  NewsState get state => _state.value;
  set state(value) => _state.value = value;

  @override
  void onInit() async {
    await loadNews();
    super.onInit();
  }

  Future<void> loadNews({bool showLoading = true}) async {
    if (showLoading) state = LoadingNewsState();
    final result = await getLatestNews();
    result.fold(
      (l) {
        Get.rawSnackbar(message: l.message);
        state = ErrorNewsState(l);
      },
      (r) {
        if (r.posts.length == 0)
          state = EmptyNewsState();
        else
          state = SuccessNewsState(r);
      },
    );
  }
}
