import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/app/app_service.dart';
import 'package:microblogging/src/core/presenter/initial_page.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/authentication/domain/usecases/logout.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/posts_controller.dart';
import 'package:microblogging/src/shared/widgets/dialogs/custom_dialog.dart';

class HomeController extends GetxController {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final Logout logout;

  User loggedUser;

  HomeController({@required this.logout});

  @override
  void onInit() {
    loggedUser = Get.find<AppService>().loggedUser;
    super.onInit();
  }

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void goToAddPostPage() {
    Get.find<PostsController>().goToAddPostPage();
  }

  Future<void> signout() async {
    Get.dialog(CustomDialog(
      contentText: 'Are you sure you want to log out?',
      confirmText: 'LOGOUT',
      onConfirmPressed: () async {
        final result = await logout();
        result.fold(
          (l) {
            Get.back();
            Get.rawSnackbar(message: l.message);
          },
          (r) => Get.offAllNamed(InitialPage.ROUTE_NAME),
        );
      },
    ));
  }
}
