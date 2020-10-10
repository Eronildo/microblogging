import 'package:get/get.dart';
import 'package:microblogging/src/core/local/drivers/get_storage_driver.dart';
import 'package:microblogging/src/core/presenter/home/home_controller.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/logout.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_database.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_datasource.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/repositories/auth_repository_impl.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(FakeDatabase(driver: Get.find<GetStorageDriver>()));
      Get.put(FakeDataSourceImpl(database: Get.find<FakeDatabase>()));
      Get.put(AuthRepositoryImpl(dataSource: Get.find<FakeDataSourceImpl>()));
      Get.put(LogoutImpl(repository: Get.find<AuthRepositoryImpl>()));
      return HomeController(logout: Get.find<LogoutImpl>());
    });
  }
}
