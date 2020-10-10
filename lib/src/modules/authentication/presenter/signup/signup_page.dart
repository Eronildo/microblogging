import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/authentication/presenter/signup/signup_controller.dart';
import 'package:microblogging/src/shared/widgets/bars/custom_app_bar.dart';
import 'package:microblogging/src/shared/widgets/buttons/custom_flat_button.dart';
import 'package:microblogging/src/shared/widgets/text_fields/custom_text_form_field.dart';

class SignupPage extends GetView<SignupController> {
  static const String ROUTE_NAME = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Form(
              key: controller.signupFormKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                      helperText: 'Required',
                      validator: controller.verifyNameIsValid,
                      onChanged: controller.onNameChange,
                      onFieldSubmitted: controller.requestEmailFocus,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email Address',
                      helperText: 'Required',
                      validator: controller.verifyEmailIsValid,
                      onChanged: controller.onEmailChange,
                      focusNode: controller.emailFocusNode,
                      onFieldSubmitted: controller.requestPasswordFocus,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        labelText: 'Password',
                        obscureText: controller.isPasswordObscure,
                        helperText: 'Required',
                        validator: controller.verifyPasswordIsValid,
                        onChanged: controller.onPasswordChange,
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
                        onFieldSubmitted:
                            controller.requestConfirmPasswordFocus,
                      ),
                    ),
                    Obx(
                      () => CustomTextFormField(
                        labelText: 'Confirm Password',
                        obscureText: controller.isPasswordObscure,
                        helperText: 'Required',
                        validator: controller.verifyPasswordIsValid,
                        onChanged: controller.onConfirmPasswordChange,
                        focusNode: controller.confirmPasswordFocusNode,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black26,
                          ),
                          onPressed: controller.togglePasswordObscure,
                        ),
                        onFieldSubmitted: controller.isSubmitButtonEnable
                            ? (_) {
                                controller.submitSignup();
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => CustomFlatButton(
                      buttonText: 'SUBMIT',
                      onPressed: controller.isSubmitButtonEnable
                          ? () {
                              controller.submitSignup();
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _appBar => CustomAppBar(
        automaticallyImplyLeading: false,
        height: 65.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.3,
                height: 65.0,
                child: FlatButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.black54,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                width: Get.width * 0.3,
                height: 65.0,
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
      );
}
