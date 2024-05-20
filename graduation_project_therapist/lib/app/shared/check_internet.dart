import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

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

bool checkIfThereIsNoConnection(ConnectivityResult connectivityResult) {
  return connectivityResult == ConnectivityResult.none ||
      (connectivityResult == ConnectivityResult.none &&
          connectivityResult == ConnectivityResult.vpn) ||
      (connectivityResult == ConnectivityResult.none &&
          connectivityResult == ConnectivityResult.bluetooth);
}

// RxBool connectionState = true.obs;

startTracking() {
  // checkInternet();
  Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
    if (checkIfThereIsNoConnection(connectivityResult)) {
      // Device is not connected to the internet

      log("Device is not connected to the internet");
      // return false;
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
