import 'package:get/get.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/core/infrastructure/services/local_storage_service_impl.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/edit_post.dart';
import 'package:microblogging/src/modules/posts/external/datasources/fake_posts_datasource.dart';
import 'package:microblogging/src/modules/posts/infrastructure/repositories/posts_repository_impl.dart';
import 'package:microblogging/src/modules/posts/presenter/edit_post/edit_post_controller.dart';

class EditPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(FakePostsDatabase());
      Get.put(FakePostsDataSource(database: Get.find<FakePostsDatabase>()));
      Get.put(PostsRepositoryImpl(dataSource: Get.find<FakePostsDataSource>()));
      Get.put(EditPostImpl(
          repository: Get.find<PostsRepositoryImpl>(),
          connectionService: Get.find<ConnectionServiceImpl>(),
          localStorageService: Get.find<LocalStorageServiceImpl>()));
      return EditPostController(editPost: Get.find<EditPostImpl>());
    });
  }
}
