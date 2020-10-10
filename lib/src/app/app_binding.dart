import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:microblogging/src/app/app_service.dart';
import 'package:microblogging/src/core/external/drivers/flutter_connectivity_driver.dart';
import 'package:microblogging/src/core/infrastructure/services/connection_service_impl.dart';
import 'package:microblogging/src/core/infrastructure/services/local_storage_service_impl.dart';
import 'package:microblogging/src/core/local/drivers/get_storage_driver.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Connectivity());
    Get.put(
        FlutterConnectivityDriver(connectivity: Get.find<Connectivity>()));
    Get.put(
        ConnectionServiceImpl(driver: Get.find<FlutterConnectivityDriver>()));
    Get.put(GetStorage());
    Get.put(GetStorageDriver(localStorage: Get.find<GetStorage>()));
    Get.put(LocalStorageServiceImpl(driver: Get.find<GetStorageDriver>()));
    Get.put(AppService(storage: Get.find<LocalStorageServiceImpl>()));
  }
}
