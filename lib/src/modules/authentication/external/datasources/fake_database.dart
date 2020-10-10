import 'package:meta/meta.dart';
import 'package:get_storage/get_storage.dart';
import 'package:microblogging/src/core/infrastructure/drivers/local_storage_driver.dart';
import 'package:microblogging/src/modules/authentication/domain/errors/auth_errors.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';

class FakeDatabase {
  final LocalStorageDriver driver;

  GetStorage _fakeStorage;
  String _userEmail;
  String _userName;
  String _userPhoto;

  FakeDatabase({@required this.driver}) {
    _fakeStorage = driver.getStorage();
  }

  Future<void> _logTheUser() async {
    await driver.setLoggedUser(
        UserModel(email: _userEmail, name: _userName, photo: _userPhoto));
  }

  Map<String, String> _getFakeResultJsonMap() => {
        "email": _userEmail,
        "name": _userName,
        "profile_picture": _userPhoto,
      };

  Future<dynamic> _makeDelay() async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  Future<Map<String, String>> signup(
      String email, String password, String name) async {
    _userEmail = email;
    _userName = name;
    _userPhoto = 'https://flutter.dev/images/favicon.png';

    await _makeDelay();

    await _fakeStorage.write(email, {
      "email": _userEmail,
      "password": password,
      "name": _userName,
      "profile_picture": _userPhoto,
    });

    await _logTheUser();

    return _getFakeResultJsonMap();
  }

  Future<dynamic> signin(String email, String password) async {
    final user = _fakeStorage.read(email);
    if (user != null) {
      if (user['password'] == password) {
        _userEmail = user['email'];
        _userName = user['name'];
        await _logTheUser();
        return user;
      } else {
        throw LoginWithEmailError(message: 'Username or password is invalid');
      }
    } else {
      throw LoginWithEmailError(
          message: 'There is no user record corresponding to this identifier.');
    }
  }

  Future<void> logout() async {
    await _makeDelay();
    await driver.removeLoggedUser();
  }
}
