import 'dart:async';
import 'package:flutter/material.dart' show Color;
import 'toast_model.dart';

class Toast {
  static final _toastsController = StreamController<ToastModel>();
  static Stream<ToastModel> get toastsStream => _toastsController.stream;

  static void add({
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color? textColor,
    Color? containerColor,
  }) =>
      _toastsController.add(ToastModel(
        message: message,
        duration: duration,
        textColor: textColor,
        containerColor: containerColor,
      ));

  void dispose() {
    _toastsController.close();
  }
}
