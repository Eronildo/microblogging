import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/authentication/presenter/login/login_page.dart';
import 'package:microblogging/src/modules/authentication/presenter/signup/signup_page.dart';
import 'package:microblogging/src/shared/widgets/buttons/custom_flat_button.dart';

class InitialPage extends StatelessWidget {
  static const String ROUTE_NAME = '/initial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                  width: Get.width * 0.7,
                  child: Image.asset('assets/images/logo.png')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'PLEASE SIGN IN TO CONTINUE',
                style: TextStyle(fontSize: 25.0, letterSpacing: 2.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.0),
            CustomFlatButton(
              buttonText: 'SIGN UP',
              onPressed: () {
                Get.toNamed(SignupPage.ROUTE_NAME);
              },
            ),
            SizedBox(height: 20.0),
            CustomFlatButton(
              isOutLined: true,
              buttonText: 'LOG IN',
              onPressed: () {
                Get.toNamed(LoginPage.ROUTE_NAME);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _termsAndPrivacyWidget,
    );
  }

  Widget get _termsAndPrivacyWidget => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text.rich(TextSpan(style: TextStyle(fontSize: 13.0), children: [
          TextSpan(text: "By signing up, I agree to Microblogging's "),
          TextSpan(
              text: "Terms of Service",
              style: TextStyle(decoration: TextDecoration.underline)),
          TextSpan(text: " and "),
          TextSpan(
              text: "Privacy Notice",
              style: TextStyle(decoration: TextDecoration.underline)),
          TextSpan(text: "."),
        ])),
      );
}
