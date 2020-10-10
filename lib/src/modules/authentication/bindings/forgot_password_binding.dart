import 'package:get/get.dart';
import 'package:microblogging/src/modules/authentication/presenter/forgot_password/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}
