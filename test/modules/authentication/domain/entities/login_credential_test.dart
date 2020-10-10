import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/authentication/domain/entities/login_credential.dart';

main() {
  test('Verify if email is valid', () {
    expect(
        LoginCredential.withEmailAndPassword(email: "something@", password: "")
            .isValidEmail,
        false);

    expect(
        LoginCredential.withEmailAndPassword(
                email: "something@some.com", password: "")
            .isValidEmail,
        true);
  });

  test('Verify if password is valid', () {
    expect(
        LoginCredential.withEmailAndPasswordAndName(
                email: "", password: "123", name: "")
            .isValidPassword,
        false);

    expect(
        LoginCredential.withEmailAndPasswordAndName(
                email: "", password: "123456", name: "")
            .isValidPassword,
        true);
  });

  test('Verify if name is valid', () {
    expect(
        LoginCredential.withEmailAndPasswordAndName(
                email: "", password: "", name: "Er")
            .isValidName,
        false);

    expect(
        LoginCredential.withEmailAndPasswordAndName(
                email: "", password: "123456", name: "Eronildo")
            .isValidName,
        true);
  });
}
