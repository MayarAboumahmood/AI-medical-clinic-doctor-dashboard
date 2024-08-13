import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:shimmer/shimmer.dart';

Widget getImageNetwork({
  required String url,
  required double? width,
  required double? height,
  Color color = Colors.transparent,
  Color? imageColor,
  BoxFit fit = BoxFit.cover,
  bool needAErrorBackgroundColor = true,
  bool fromBackEnd = true,
  bool forProfileImage = false,
}) {
  return Container(
    width: width,
    color: color,
    height: height,
    child: Image.network(
      url,
      color: imageColor,
      alignment: Alignment.center,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null ||
            loadingProgress.expectedTotalBytes == null) {
          return child; // Image is loaded or the total size is not determined.
        }
        if (loadingProgress.cumulativeBytesLoaded <
            loadingProgress.expectedTotalBytes!) {
          return buildLoadingShimmer(
              width ?? responsiveUtil.screenWidth,
              height ??
                  responsiveUtil
                      .screenHeight); // Show shimmer when image is loading
        }
        return child; // Image has finished loading
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        print('the error while opening the image: $error');
        return buildErrorBody(
            needAErrorBackgroundColor, width, height, forProfileImage);
      },
    ),
  );
}

Widget imageLoader({
  required String url,
  required double? width,
  required double? height,
  Color? color,
  BoxFit fit = BoxFit.cover,
  bool fromBackEnd = true,
  bool forProfileImage = false,
}) {
  // if (fromBackEnd) {
  //   url = ServerConfig.imageUrl + url;
  // }

  return CachedNetworkImage(
      width: width,
      color: color,
      height: height,
      fit: fit,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          buildLoadingShimmer(width, height),
      errorWidget: (context, url, error) {
        return buildErrorBody(true, width, height, forProfileImage);
      });
}

Shimmer buildLoadingShimmer(double? width, double? height) {
  return Shimmer.fromColors(
    baseColor: customColors.secondaryBackGround,
    highlightColor: customColors.primaryBackGround,
    child: Container(
      width: width,
      height: height,
      color: customColors.primaryBackGround,
    ),
  );
}

Container buildErrorBody(bool needAErrorBackgroundColor, double? width,
    double? height, bool forProfileImage) {
  return Container(
    color: needAErrorBackgroundColor ? customColors.secondaryBackGround : null,
    width: width,
    height: height,
    child: forProfileImage
        ? Image.asset('assets/images/first charecater.png')
        : const Center(
            child: Icon(
              Icons.error,
            ),
          ),
  );
}
