import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/app/app_service.dart';
import 'package:microblogging/src/core/presenter/home/home_page.dart';
import 'package:microblogging/src/core/presenter/loading_page.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';

import 'package:microblogging/src/modules/authentication/domain/usecases/signup_with_email.dart';

class SignupController extends GetxController {
  final SignupWithEmail signupWithEmail;

  final signupFormKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final _credential = LoginCredential();
  String _confirmPasswordValue = '';

  final _isSubmitButtonEnable = false.obs;
  final _isPasswordObscure = true.obs;

  SignupController({@required this.signupWithEmail});

  @override
  onClose() async {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    await super.onClose();
  }

  bool get isSubmitButtonEnable => _isSubmitButtonEnable.value;
  set isSubmitButtonEnable(value) => _isSubmitButtonEnable.value = value;

  bool get isPasswordObscure => _isPasswordObscure.value;
  set isPasswordObscure(value) => _isPasswordObscure.value = value;

  bool get _isPasswordsMatch => _credential.password == _confirmPasswordValue;

  void _checkIfAllFieldsAreFilled() {
    isSubmitButtonEnable = _credential.name.isNotEmpty &&
        _credential.email.isNotEmpty &&
        _credential.password.isNotEmpty &&
        _confirmPasswordValue.isNotEmpty;
  }

  void requestEmailFocus(String value) {
    FocusScope.of(Get.context).requestFocus(emailFocusNode);
  }

  void requestPasswordFocus(String value) {
    FocusScope.of(Get.context).requestFocus(passwordFocusNode);
  }

  void requestConfirmPasswordFocus(String value) {
    FocusScope.of(Get.context).requestFocus(confirmPasswordFocusNode);
  }

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
  }

  String verifyNameIsValid(value) {
    if (_credential.name.isEmpty) return 'Required';
    return _credential.isValidName
        ? null
        : 'Name must be a minimum of 3 characters';
  }

  String verifyEmailIsValid(value) {
    if (_credential.email.isEmpty) return 'Required';
    return _credential.isValidEmail
        ? null
        : 'Please enter a valid email address';
  }

  String verifyPasswordIsValid(value) {
    if (_credential.password.isEmpty) return 'Required';
    if (!_credential.isValidPassword)
      return 'Password must be a minimum of 4 characters';
    return _isPasswordsMatch ? null : 'Password does not match';
  }

  void onNameChange(String value) {
    _credential.name = value.trim();
    _checkIfAllFieldsAreFilled();
  }

  void onEmailChange(String value) {
    _credential.email = value.trim();
    _checkIfAllFieldsAreFilled();
  }

  void onPasswordChange(String value) {
    _credential.password = value.trim();
    _checkIfAllFieldsAreFilled();
  }

  void onConfirmPasswordChange(String value) {
    _confirmPasswordValue = value.trim();
    _checkIfAllFieldsAreFilled();
  }

  void submitSignup() async {
    final form = signupFormKey.currentState;
    if (form.validate()) {
      form.save();
      Get.toNamed(LoadingPage.ROUTE_NAME, arguments: 'SIGNING UP');
      final result = await signupWithEmail(_credential);
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
