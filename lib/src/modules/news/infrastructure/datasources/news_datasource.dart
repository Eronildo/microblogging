import 'package:microblogging/src/modules/news/infrastructure/models/news_model.dart';

abstract class NewsDataSource {
  Future<NewsModel> getLatestNews();
}
