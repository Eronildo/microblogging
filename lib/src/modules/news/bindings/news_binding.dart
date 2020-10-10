import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/core/domain/usecases/sort_posts_chronologically.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/modules/news/domain/usecases/get_latest_news.dart';
import 'package:microblogging/src/modules/news/external/datasources/aws_news_datasource.dart';
import 'package:microblogging/src/modules/news/infrastructure/repositories/news_repository_impl.dart';
import 'package:microblogging/src/modules/news/presenter/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(Dio());
      Get.put(AwsNewsDataSource(dio: Get.find<Dio>()));
      Get.put(NewsRepositoryImpl(datasource: Get.find<AwsNewsDataSource>()));
      Get.put(SortPostsChronologicallyImpl());
      Get.put(GetLatestNewsImpl(
          repository: Get.find<NewsRepositoryImpl>(),
          connectionService: Get.find<ConnectionServiceImpl>(),
          sortPostsChronologically: Get.find<SortPostsChronologicallyImpl>()));
      return NewsController(getLatestNews: Get.find<GetLatestNewsImpl>());
    });
  }
}
