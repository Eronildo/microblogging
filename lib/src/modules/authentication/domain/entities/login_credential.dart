import 'package:meta/meta.dart';
import 'package:get/utils.dart';

class LoginCredential {
  String email;
  String password;
  String name;

  LoginCredential({this.email, this.password, this.name});

  factory LoginCredential.withEmailAndPassword(
      {@required String email, @required String password}) {
    return LoginCredential(email: email, password: password);
  }

  factory LoginCredential.withEmailAndPasswordAndName(
      {@required String email,
      @required String password,
      @required String name}) {
    return LoginCredential(email: email, password: password, name: name);
  }

  bool get isValidEmail => GetUtils.isEmail(email);

  bool get isValidPassword =>
      password != null && password.isNotEmpty && password.length > 3;

  bool get isValidName =>
      name != null && name.isNotEmpty && name.length > 2;
}
