import 'package:get/get.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/add_post.dart';
import 'package:microblogging/src/modules/posts/external/datasources/fake_posts_datasource.dart';
import 'package:microblogging/src/modules/posts/infrastructure/repositories/posts_repository_impl.dart';
import 'package:microblogging/src/modules/posts/presenter/add_post/add_post_controller.dart';

class AddPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(FakePostsDatabase());
      Get.put(FakePostsDataSource(database: Get.find<FakePostsDatabase>()));
      Get.put(PostsRepositoryImpl(dataSource: Get.find<FakePostsDataSource>()));
      Get.put(AddPostImpl(
          repository: Get.find<PostsRepositoryImpl>(),
          connectionService: Get.find<ConnectionServiceImpl>()));
      return AddPostController(addPost: Get.find<AddPostImpl>());
    });
  }
}
