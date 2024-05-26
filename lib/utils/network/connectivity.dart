import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectionService {
  Future<bool> isDeviceConnected() async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus.contains(ConnectivityResult.mobile) ||
        connectionStatus.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }
}
