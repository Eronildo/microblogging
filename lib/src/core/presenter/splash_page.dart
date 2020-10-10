import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  static const String ROUTE_NAME = '/splash';

  @override
  Widget build(BuildContext context) {
    // Get.find<AppService>();
    return Scaffold(
      body: Center(child: SizedBox(
        width: Get.width * 0.8,
          child: Image.asset('assets/images/logo.png'))),
    );
  }
}
