import 'package:flutter/material.dart';

///Take list of model and generat list of custom cards
List<Widget> generateCards<T>({
  required List<T> models,
  required Widget Function(T) cardBuilder,
}) {
  return models.map((model) => cardBuilder(model)).toList();
}
