import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/core/external/drivers/flutter_connectivity_driver.dart';
import 'package:mockito/mockito.dart';

class ConnectivityMock extends Mock implements Connectivity {}

main() {
  final connectivity = ConnectivityMock();
  final driver = FlutterConnectivityDriver(connectivity: connectivity);

  test('Should return true when ConnectivityResult is mobile', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.mobile);
    final result = await driver.isOnline;
    expect(result, true);
  });

  test('Should return true when ConnectivityResult is wifi', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.wifi);
    final result = await driver.isOnline;
    expect(result, true);
  });

  test('Should return false when ConnectivityResult is none', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.none);
    final future = driver.isOnline;
    expect(future, completion(false));
  });

  test('Should throw Exception', () async {
    when(connectivity.checkConnectivity()).thenThrow(Exception());
    final future = driver.isOnline;
    expect(future, throwsA(isA<Exception>()));
  });
}
