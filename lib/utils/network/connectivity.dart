import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectionService {
  Future<bool> isDeviceConnected() async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus == ConnectivityResult.mobile ||
        connectionStatus == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
