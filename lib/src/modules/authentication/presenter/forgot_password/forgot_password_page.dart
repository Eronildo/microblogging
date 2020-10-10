import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/shared/widgets/bars/custom_app_bar.dart';
import 'package:microblogging/src/shared/widgets/buttons/custom_flat_button.dart';
import 'package:microblogging/src/shared/widgets/text_fields/custom_text_form_field.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  static const String ROUTE_NAME = '/forgot';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'FORGOT YOUR PASSWORD?',
                      style: TextStyle(fontSize: 25.0, letterSpacing: 3.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                CustomTextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email Address',
                  validator: controller.verifyEmailIsValid,
                  onSaved: controller.onEmailSaved,
                  onFieldSubmitted: (_) {
                    controller.submit();
                  },
                ),
                Expanded(child: SizedBox(height: 1.0)),
                CustomFlatButton(
                  buttonText: 'SUBMIT',
                  onPressed: () {
                    controller.submit();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
