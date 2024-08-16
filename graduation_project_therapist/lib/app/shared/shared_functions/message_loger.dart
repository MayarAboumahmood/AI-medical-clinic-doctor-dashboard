// //this class help to store the string I want in the local memories as json.
// import 'dart:convert';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:external_path/external_path.dart';

// class MessageLogger {
//   static Future<String?> get _logFilePath async {
//     String? path;

//     if (Platform.isAndroid) {
//       var status = await Permission.manageExternalStorage.request();
//       if (status.isGranted) {
//         path = await ExternalPath.getExternalStoragePublicDirectory(
//             ExternalPath.DIRECTORY_DOWNLOADS);
//       } else {
//         return null;
//       }
//     } else if (Platform.isIOS) {
//       final directory = await getApplicationDocumentsDirectory();
//       path = directory.path;
//     } else {
//       return null;
//     }

//     return '$path/error_messages.json';
//   }

//   static Future<void> logMessage(String message) async {
//     final logFilePath = await _logFilePath;
//     if (logFilePath == null) {
//       print('Failed to get log file path');
//       return;
//     }

//     final File logFile = File(logFilePath);
//     List<dynamic> logs = [];

//     try {
//       if (await logFile.exists()) {
//         String content = await logFile.readAsString();
//         logs = jsonDecode(content);
//       } else {
//         await logFile.create(recursive: true);
//       }

//       logs.add(message);

//       await logFile.writeAsString(jsonEncode(logs), mode: FileMode.write);
//     } catch (e) {
//       print('Failed to log message: $e');
//     }
//   }
// }
