import 'dart:math';

import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';

String getMessageTypeFromEnvelope(MessageTypeEnum messageType) {
  switch (messageType) {
    case MessageTypeEnum.text:
      return 'text';
    case MessageTypeEnum.image:
      return 'image';
    case MessageTypeEnum.voice:
      return 'voice';
    default:
      return 'text';
  }
}

MessageTypeEnum messageTypeFromString(String type) {
  switch (type) {
    case 'text':
      return MessageTypeEnum.text;
    case 'image':
      return MessageTypeEnum.image;
    case 'voice':
      return MessageTypeEnum.voice;
    default:
      throw MessageTypeEnum.text;
  }
}

bool hasMessageData(Map<String, dynamic> messageObj) {
  if (messageObj.containsKey('message')) {
    Map<String, dynamic> message = messageObj['message'];

    if (message.containsKey('content') &&
        message['content'] != null &&
        message['content'].toString().isNotEmpty) {
      return true;
    }
    if (message.containsKey('senderId') && message['senderId'] != null) {
      return true;
    }
    if (message.containsKey('messageType') &&
        message['messageType'] != null &&
        message['messageType'].toString().isNotEmpty) {
      return true;
    }
  }
  return false;
}

String assignChannelName(int userID, int user2ID) {
  int firstID = max(userID, user2ID);
  int secondID = min(userID, user2ID);
  return '${firstID}fortime$secondID';
  // return 'chat_channel';
}

String getFileSenderID(String input) {
  int delimiterIndex = input.indexOf('///');
  if (delimiterIndex == -1) {
    // If the delimiter is not found, return the whole string or handle as needed
    return input;
  }
  return input.substring(0, delimiterIndex);
}

String getFileDate(String input) {
  int delimiterIndex = input.indexOf('///');
  if (delimiterIndex == -1) {
    // If the delimiter is not found, return an empty string or handle as needed
    return '';
  }
  // Adding 3 to skip the length of '///'
  return input.substring(delimiterIndex + 3);
}
