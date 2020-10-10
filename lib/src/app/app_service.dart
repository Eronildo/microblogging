import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/domain/services/local_storage_service.dart';
import 'package:microblogging/src/core/presenter/home/home_page.dart';
import 'package:microblogging/src/core/presenter/initial_page.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';

class AppService extends GetxService {
  final LocalStorageService storage;
  final _loggedUser = User().obs;

  final _initialPageName = InitialPage.ROUTE_NAME;
  final _homePageName = HomePage.ROUTE_NAME;

  AppService({@required this.storage});

  User get loggedUser => _loggedUser.value;
  set loggedUser(value) => _loggedUser.value = value;

  @override
  void onInit() {
    _loadLoggedUser();
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(Duration(seconds: 1));
    _redirectToLoginOrHomePage();
    super.onReady();
  }

  void _loadLoggedUser() {
    final storageResult = storage.getLoggedUser();
    storageResult.fold((l) => null, (r) => loggedUser = r);
  }

  void _redirectToLoginOrHomePage() {
    Get.offAllNamed(loggedUser == null ? _initialPageName : _homePageName,
        arguments: loggedUser);
  }
}
