// import 'dart:developer';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/foundation.dart';

// Future<bool> checkInternet() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.none ||
//       (connectivityResult == ConnectivityResult.none &&
//           connectivityResult == ConnectivityResult.vpn) ||
//       (connectivityResult == ConnectivityResult.none &&
//           connectivityResult == ConnectivityResult.bluetooth)) {
//     // Device is not connected to the internet
//     log("Device is not connected to the internet");
//     return false;
//   } else {
//     log("Device is connected to the internet");
//     // Device is connected to the internet
//     return true;
//   }
// }

// // RxBool connectionState = true.obs;

// void startTracking() {
//   // checkInternet();
//   Connectivity().onConnectivityChanged.listen(
//     (List<ConnectivityResult> connectivityResults) {
//       // Check if any result is `ConnectivityResult.none`
//       bool isDisconnected =
//           connectivityResults.contains(ConnectivityResult.none) ||
//               (connectivityResults.contains(ConnectivityResult.none) &&
//                   connectivityResults.contains(ConnectivityResult.vpn)) ||
//               (connectivityResults.contains(ConnectivityResult.none) &&
//                   connectivityResults.contains(ConnectivityResult.bluetooth));

//       // Device is not connected to the internet
//       if (isDisconnected) {
//         log("Device is not connected to the internet");
//       } else {
//         log("Device is connected to the internet in tracking");
//         // Device is connected to the internet
//       }
//     },
//     onError: (e) {
//       if (kDebugMode) {
//         print("connection error $e");
//       }
//     },
//     onDone: () {
//       if (kDebugMode) {
//         print("connection done");
//       }
//     },
//   );
// }
