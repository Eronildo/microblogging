import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/app/app_service.dart';
import 'package:microblogging/src/core/presenter/home/home_page.dart';
import 'package:microblogging/src/core/presenter/loading_page.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/login_with_email.dart';

class LoginController extends GetxController {
  final LoginWithEmail loginWithEmail;
  final loginFormKey = GlobalKey<FormState>();
  final passwordFocusNode = FocusNode();
  final _credential = LoginCredential();
  final _isPasswordObscure = true.obs;

  LoginController({@required this.loginWithEmail});

  @override
  onClose() {
    passwordFocusNode.dispose();
  }

  bool get isPasswordObscure => _isPasswordObscure.value;
  set isPasswordObscure(value) => _isPasswordObscure.value = value;

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
  }

  void requestPasswordFocus(String value) {
    FocusScope.of(Get.context).requestFocus(passwordFocusNode);
  }

  String verifyEmailIsValid(String value) {
    if (value.isEmpty) return 'Required';
    _credential.email = value.trim();
    return _credential.isValidEmail
        ? null
        : 'Please enter a valid email address';
  }

  String verifyPasswordIsValid(String value) {
    if (value.isEmpty) return 'Required';
    _credential.password = value.trim();
    return _credential.isValidPassword
        ? null
        : 'Password must be a minimum of 4 characters';
  }

  void onEmailSaved(String value) {
    _credential.email = value.trim();
  }

  void onPasswordSaved(String value) {
    _credential.password = value.trim();
  }

  void submitLogin() async {
    final form = loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      Get.toNamed(LoadingPage.ROUTE_NAME, arguments: 'SIGNING IN');
      final result = await loginWithEmail(_credential);
      result.fold(
        (l) {
          Get.back();
          Get.rawSnackbar(message: l.message);
        },
        (r) {
          Get.find<AppService>().loggedUser = r;
          Get.offAllNamed(HomePage.ROUTE_NAME);
        },
      );
    }
  }
}
