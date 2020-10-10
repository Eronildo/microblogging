import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> loginWithEmail({String email, String password});
  Future<void> logout();
  Future<UserModel> signupWithEmail(
      {String email, String password, String name});
}
