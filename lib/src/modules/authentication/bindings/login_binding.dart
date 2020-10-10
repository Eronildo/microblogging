import 'package:get/get.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/core/local/drivers/get_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/login_with_email.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_database.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_datasource.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/repositories/auth_repository_impl.dart';
import 'package:microblogging/src/modules/authentication/presenter/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(FakeDatabase(driver: Get.find<GetStorageDriver>()));
      Get.put(FakeDataSourceImpl(database: Get.find<FakeDatabase>()));
      Get.put(AuthRepositoryImpl(dataSource: Get.find<FakeDataSourceImpl>()));
      Get.put(LoginWithEmailImpl(
        repository: Get.find<AuthRepositoryImpl>(),
        connectionService: Get.find<ConnectionServiceImpl>(),
      ));
      return LoginController(loginWithEmail: Get.find<LoginWithEmailImpl>());
    });
  }
}
