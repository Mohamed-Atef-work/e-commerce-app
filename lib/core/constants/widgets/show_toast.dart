import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

showMyToast(
  String msg,
  BuildContext context,
  Color backgroundColor,
) =>
    showToast(
      msg,
      context: context,
      dismissOtherToast: true,
      backgroundColor: backgroundColor,
    );

enum ToastState {
  error,
  success,
}
