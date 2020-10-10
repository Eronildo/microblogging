import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  static const String ROUTE_NAME = '/loading';

  @override
  Widget build(BuildContext context) {
    final message = Get.arguments ?? '';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 30.0,
                letterSpacing: 3.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
