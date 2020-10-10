import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/core/presenter/loading_page.dart';
import 'package:microblogging/src/shared/widgets/dialogs/custom_dialog.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String _email = '';

  String verifyEmailIsValid(String value) {
    if (value.isEmpty) return 'Required';
    _email = value;
    return GetUtils.isEmail(value)
        ? null
        : 'Please enter a valid email address';
  }

  void onEmailSaved(String value) {
    _email = value;
  }

  void submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Get.toNamed(
        LoadingPage.ROUTE_NAME,
      );
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      Get.dialog(CustomDialog(
        contentText:
            'A link to reset your password has been sent to your email address.',
        confirmText: 'OK',
        showCancelButton: false,
      ));
    }
  }
}
