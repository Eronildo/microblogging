import 'package:get/get.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/core/local/drivers/get_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/signup_with_email.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_database.dart';
import 'package:microblogging/src/modules/authentication/external/datasources/fake_datasource.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/repositories/auth_repository_impl.dart';
import 'package:microblogging/src/modules/authentication/presenter/signup/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(FakeDatabase(driver: Get.find<GetStorageDriver>()));
      Get.put(FakeDataSourceImpl(database: Get.find<FakeDatabase>()));
      Get.put(AuthRepositoryImpl(dataSource: Get.find<FakeDataSourceImpl>()));
      Get.put(SignupWithEmailImpl(
        repository: Get.find<AuthRepositoryImpl>(),
        connectionService: Get.find<ConnectionServiceImpl>(),
      ));
      return SignupController(signupWithEmail: Get.find<SignupWithEmailImpl>());
    });
  }
}
