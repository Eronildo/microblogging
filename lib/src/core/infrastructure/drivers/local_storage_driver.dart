import 'package:get_storage/get_storage.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';

abstract class LocalStorageDriver {
  UserModel getLoggedUser();
  Future<void> setLoggedUser(UserModel user);
  Future<void> removeLoggedUser();
  GetStorage getStorage();
}
