import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/core/infrastructure/drivers/connection_driver.dart';

class FlutterConnectivityDriver implements ConnectionDriver {
  final Connectivity connectivity;

  FlutterConnectivityDriver({@required this.connectivity});

  @override
  Future<bool> get isOnline async {
    final result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }
}
