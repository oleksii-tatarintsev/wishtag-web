import 'dart:math';

import 'package:flutter/material.dart';

class ToastModel {
  final double id = Random().nextDouble();
  final String message;
  final Duration duration;
  final Color? textColor;
  final Color? containerColor;

  ToastModel({
    required this.message,
    this.duration = const Duration(seconds: 2),
    this.textColor,
    this.containerColor,
  });

  @override
  bool operator ==(Object other) =>
      other is ToastModel && other.id == id && other.message == message && other.duration == other.duration;

  @override
  int get hashCode => id.hashCode ^ message.hashCode ^ duration.hashCode;
}
