import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

showMyToast(
  String msg,
  Color backgroundColor,
) =>
    showToast(
      msg,
      //textColor: Colors.white,
      backgroundColor: backgroundColor,
    );

enum ToastState {
  error,
  success,
}
