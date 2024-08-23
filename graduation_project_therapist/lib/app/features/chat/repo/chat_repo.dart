import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/data_source/data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/data_source/model/chat_info_model.dart';

class ChatRepositoryImp {
  final ChatDataSource _chatDataSource;

  ChatRepositoryImp(this._chatDataSource);

  Future<Either<String, ChatInfoModel>> getChatInformation(
      int patientId) async {
    try {
      final response = await _chatDataSource.getChatInformation(patientId);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ChatInfoModel chatInfoModel = ChatInfoModel.fromJson(decodedResponse);
        return right(chatInfoModel);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> sendCompleteSession(int appointmentId) async {
    try {
      final response = await _chatDataSource.sendCompleteSession(appointmentId);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, bool>> checkIfSessionComplete(int appointmentId) async {
    try {
      final response =
          await _chatDataSource.checkIfSessionComplete(appointmentId);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        decodedResponse['status'];
        return right(decodedResponse['data']['status']);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in check if session completed repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> reportVideoCall(
      int appointmentId, String description, Uint8List pic) async {
    try {
      final response = await _chatDataSource.reportVideoCall(
          appointmentId, description, pic);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        decodedResponse['status'];
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in report Video Call repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> sendToBackendForNotification(
      int patientID, String userName, String type) async {
    try {
      final response = await _chatDataSource.sendToBackendForNotification(
          patientID, userName, type);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        decodedResponse['status'];
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in send to backend to send notification repo: $e');
      return left('Server Error');
    }
  }
}
