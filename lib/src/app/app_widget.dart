import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:microblogging/src/app/app_binding.dart';
import 'package:microblogging/src/app/app_routes.dart';
import 'package:microblogging/src/app/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Microblogging',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.initialRoute,
      initialBinding: AppBinding(),
      getPages: AppRoutes.pages,
    );
  }
}
