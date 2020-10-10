import 'package:meta/meta.dart';
import 'package:get_storage/get_storage.dart';
import 'package:microblogging/src/core/infrastructure/drivers/local_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';

class GetStorageDriver implements LocalStorageDriver {
  final GetStorage localStorage;

  final String _loggedUserKey = "LoggedUserKey";

  GetStorageDriver({@required this.localStorage});

  @override
  UserModel getLoggedUser() {
    final userJson = localStorage.read(_loggedUserKey);
    if (userJson != null) return UserModel.fromJson(userJson);
    return null;
  }

  @override
  Future<void> setLoggedUser(UserModel user) async =>
      await localStorage.write(_loggedUserKey, user);

  @override
  Future<void> removeLoggedUser() async =>
      await localStorage.remove(_loggedUserKey);

  @override
  GetStorage getStorage() {
    return localStorage;
  }
}
