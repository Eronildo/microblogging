import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/authentication/presenter/forgot_password/forgot_password_page.dart';
import 'package:microblogging/src/modules/authentication/presenter/login/login_controller.dart';
import 'package:microblogging/src/shared/widgets/bars/custom_app_bar.dart';
import 'package:microblogging/src/shared/widgets/buttons/custom_flat_button.dart';
import 'package:microblogging/src/shared/widgets/text_fields/custom_text_form_field.dart';

class LoginPage extends GetView<LoginController> {
  static const String ROUTE_NAME = '/login';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          actions: [
            FlatButton(
              onPressed: () {
                Get.toNamed(ForgotPasswordPage.ROUTE_NAME);
              },
              child: Text(
                'FORGOT PASSWORD?',
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'LOG IN',
                    style: TextStyle(fontSize: 25.0, letterSpacing: 3.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.0),
                CustomTextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email Address',
                  validator: controller.verifyEmailIsValid,
                  onSaved: controller.onEmailSaved,
                  onFieldSubmitted: controller.requestPasswordFocus,
                ),
                SizedBox(height: 10.0),
                Obx(
                  () => CustomTextFormField(
                    labelText: 'Password',
                    obscureText: controller.isPasswordObscure,
                    validator: controller.verifyPasswordIsValid,
                    onSaved: controller.onPasswordSaved,
                    focusNode: controller.passwordFocusNode,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black26,
                      ),
                      onPressed: controller.togglePasswordObscure,
                    ),
                    onFieldSubmitted: (_) {
                      controller.submitLogin();
                    },
                  ),
                ),
                Expanded(child: SizedBox(height: 1.0)),
                CustomFlatButton(
                  buttonText: 'LOG IN',
                  onPressed: () {
                    controller.submitLogin();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
