import 'package:microblogging/src/modules/authentication/external/datasources/fake_database.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/datasources/auth_datasource.dart';
import 'package:microblogging/src/modules/authentication/infrastructure/models/user_model.dart';
import 'package:meta/meta.dart';

class FakeDataSourceImpl implements AuthDataSource {
  final FakeDatabase database;

  FakeDataSourceImpl({@required this.database});
  @override
  Future<UserModel> loginWithEmail({String email, String password}) async {
    final result = await database.signin(email, password);
    return UserModel.fromMap(result);
  }

  @override
  Future<void> logout() async {
    return await database.logout();
  }

  @override
  Future<UserModel> signupWithEmail(
      {String email, String password, String name}) async {
    var result = await database.signup(email, password, name);
    return UserModel.fromMap(result);
  }
}
