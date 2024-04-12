import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (checkIfThereIsNoConnection(connectivityResult)) {
    // Device is not connected to the internet
    log("Device is not connected to the internet");
    return false;
  } else {
    log("Device is connected to the internet");
    // Device is connected to the internet
    return true;
  }
}

bool checkIfThereIsNoConnection(List<ConnectivityResult> connectivityResult) {
  return connectivityResult.contains(ConnectivityResult.none) ||
      (connectivityResult.contains(ConnectivityResult.none) &&
          connectivityResult.contains(ConnectivityResult.vpn)) ||
      (connectivityResult.contains(ConnectivityResult.none) &&
          connectivityResult.contains(ConnectivityResult.bluetooth));
}


/*startTracking() {
  Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none ||
        (connectivityResult == ConnectivityResult.none &&
            connectivityResult == ConnectivityResult.vpn) ||
        (connectivityResult == ConnectivityResult.none &&
            connectivityResult == ConnectivityResult.bluetooth)) {
      // Device is not connected to the internet

      log("Device is not connected to the internet");
    } else {
      log("Device is connected to the internet in tracking");
      // Device is connected to the internet
    }
  }, onError: (e) {
    if (kDebugMode) {
      print("connection error $e");
    }
  }, onDone: () {
    if (kDebugMode) {
      print("connection done");
    }
  });
}
*/