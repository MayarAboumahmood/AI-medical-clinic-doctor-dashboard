import 'dart:convert';

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
}
