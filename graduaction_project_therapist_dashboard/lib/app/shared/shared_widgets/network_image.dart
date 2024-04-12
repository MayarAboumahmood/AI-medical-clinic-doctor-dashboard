import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
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
}) {
  return Container(
    width: width,
    color: color,
    height: height,
    child: Image.network(
      ServerConfig.images + url,
      color: imageColor,
      alignment: Alignment.center,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress != null) {
          return buildLoadingShimmer(width, height);
        }
        return child;
        // Image has finished loading
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return buildErrorBody(needAErrorBackgroundColor, width, height);
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
}) {
  return CachedNetworkImage(
      width: width,
      color: color,
      height: height,
      fit: fit,
      imageUrl: ServerConfig.images + url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          buildLoadingShimmer(width, height),
      errorWidget: (context, url, error) =>
          buildErrorBody(true, width, height));
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

Container buildErrorBody(
    bool needAErrorBackgroundColor, double? width, double? height) {
  return Container(
    color: needAErrorBackgroundColor ? customColors.secondaryBackGround : null,
    width: width,
    height: height,
    child: const Center(
      child: Icon(
        Icons.error,
      ),
    ),
  );
}
