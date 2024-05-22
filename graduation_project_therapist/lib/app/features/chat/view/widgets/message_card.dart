import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class MessageCard extends StatelessWidget {
  final String? text;
  final Uri? imageData;
  final bool iAmTheSender;
  final bool isConsecutiveMessage;
  final MessageTypeEnum messageType;

  const MessageCard({
    Key? key,
    required this.text,
    this.imageData,
    required this.iAmTheSender,
    required this.isConsecutiveMessage,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (messageType) {
      case MessageTypeEnum.text:
        return BubbleSpecialThree(
          text: text ?? '',
          textStyle: customTextStyle.bodyMedium,
          tail: isConsecutiveMessage,
          color: iAmTheSender ? customColors.primary : customColors.completeded,
          isSender: iAmTheSender,
        );
      case MessageTypeEnum.image:
        return imageData == null ? const SizedBox.shrink() : imageCard();
      default:
        return const SizedBox.shrink();
    }
  }

/*
/v1/files/sub-c-8fbae32e-cb72-4994-b3db-0ddbdf57f043/channels/2graduationProjectll1/files/7a63c05f-086c-408c-8b9c-dff805fdc63a/f52e61ca-fb52-4c21-b4c6-46a023ae9fde3228954913482788058.jpg


 */
  Align imageCard() {
    print(
        'file path sssssssssssssssssssssssss: in image card ${imageData!.path}');
    return Align(
        alignment: iAmTheSender ? Alignment.topRight : Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: responsiveUtil.screenWidth * .4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: customColors.primary)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageData!.toString(),
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return buildErrorBody(true, responsiveUtil.screenWidth * .4,
                        responsiveUtil.screenWidth * .4);
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null ||
                        loadingProgress.expectedTotalBytes == null) {
                      return child; // Image is loaded or the total size is not determined.
                    }
                    if (loadingProgress.cumulativeBytesLoaded <
                        loadingProgress.expectedTotalBytes!) {
                      return buildLoadingShimmer(
                        responsiveUtil.screenWidth * .4,
                        responsiveUtil.screenWidth * .4,
                      ); // Show shimmer when image is loading
                    }
                    return child; // Image has finished loading
                  },
                  fit: BoxFit.fitWidth,
                )),
          ),
        ));
  }
}
