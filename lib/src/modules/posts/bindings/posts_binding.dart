import 'package:get/get.dart';
import 'package:microblogging/src/core/domain/usecases/sort_posts_chronologically.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/core/infrastructure/services/local_storage_service_impl.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/delete_post.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/get_posts.dart';
import 'package:microblogging/src/modules/posts/external/datasources/fake_posts_datasource.dart';
import 'package:microblogging/src/modules/posts/infrastructure/repositories/posts_repository_impl.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/posts_controller.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(FakePostsDatabase());
      Get.put(FakePostsDataSource(database: Get.find<FakePostsDatabase>()));
      Get.put(PostsRepositoryImpl(dataSource: Get.find<FakePostsDataSource>()));
      Get.put(SortPostsChronologicallyImpl());
      Get.put(GetPostsImpl(
          repository: Get.find<PostsRepositoryImpl>(),
          connectionService: Get.find<ConnectionServiceImpl>(),
          sortPostsChronologically: Get.find<SortPostsChronologicallyImpl>()));
      Get.put(DeletePostImpl(
          repository: Get.find<PostsRepositoryImpl>(),
          connectionService: Get.find<ConnectionServiceImpl>(),
          localStorageService: Get.find<LocalStorageServiceImpl>()));
      return PostsController(
          getPosts: Get.find<GetPostsImpl>(),
          deletePost: Get.find<DeletePostImpl>());
    });
  }
}
