// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'toast_controller.dart';
import 'toast_model.dart';

class ToastWrapper extends StatefulWidget {
  final Widget child;
  const ToastWrapper({
    required this.child,
    super.key,
  });
  @override
  State createState() => _ToastWrapperState();
}

class _ToastWrapperState extends State<ToastWrapper> {
  final _toasts = Queue<ToastModel>();
  final _toastsStreamController = StreamController<ToastModel>();
  bool _isToastRunning = false;

  @override
  void initState() {
    _listenForMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: widget.child,
          ),
          _Toast(
            toastsStream: _toastsStreamController.stream,
            onAnimationEnd: _nextMessage,
          ),
        ],
      ),
    );
  }

  void _listenForMessages() {
    Toast.toastsStream.listen((event) {
      _toasts.add(event);
      if (!_isToastRunning) {
        _nextMessage();
      }
    });
  }

  void _nextMessage() {
    _isToastRunning = false;
    if (_toasts.isNotEmpty) {
      _toastsStreamController.add(_toasts.first);
      _toasts.removeFirst();
      _isToastRunning = true;
    }
  }

  @override
  void dispose() {
    _toastsStreamController.close();
    super.dispose();
  }
}

class _Toast extends StatefulWidget {
  final Stream<ToastModel> toastsStream;
  final VoidCallback onAnimationEnd;
  const _Toast({
    required this.toastsStream,
    required this.onAnimationEnd,
  });
  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<_Toast> with TickerProviderStateMixin {
  AnimationController? animationController;
  late StreamSubscription<ToastModel> _toastSubscription;
  String message = '';
  Color containerColor = Colors.green;
  Color textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _toastSubscription = widget.toastsStream.listen((_) {});
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    animationController?.addListener(() => setState(() {}));
    _toastSubscription.onData((data) {
      message = data.message;
      containerColor = data.containerColor ?? Colors.green;
      textColor = data.textColor ?? Colors.white;
      animationController?.forward().whenComplete(() {
        Future.delayed(data.duration)
            .then((value) => animationController?.reverse().whenComplete(widget.onAnimationEnd));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (animationController?.value ?? 0) * 130 - 100,
      left: 10,
      right: 10,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    _toastSubscription.cancel();
    super.dispose();
  }
}
