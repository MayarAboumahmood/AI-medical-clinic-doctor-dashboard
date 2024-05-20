import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<Uint8List?> assetImageToUint8List(AssetImage assetImage) async {
  final ImageStream stream = assetImage.resolve(const ImageConfiguration());
  final Completer<ui.Image> imageCompleter = Completer<ui.Image>();
  final Completer<Uint8List?> byteDataCompleter = Completer<Uint8List?>();

  stream.addListener(
    ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        imageCompleter.complete(info.image);
      }
    )
  );

  final ui.Image image = await imageCompleter.future;
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  if (byteData != null) {
    byteDataCompleter.complete(byteData.buffer.asUint8List());
  } else {
    byteDataCompleter.complete(null);
  }

  return byteDataCompleter.future;
}