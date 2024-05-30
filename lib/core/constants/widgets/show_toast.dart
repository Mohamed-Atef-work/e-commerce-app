import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

showMyToast(String msg, BuildContext context, Color backgroundColor,
        [StyledToastPosition? position]) =>
    showToast(
      msg,
      context: context,
      position: position,
      dismissOtherToast: true,
      backgroundColor: backgroundColor,
    );

enum ToastState {
  error,
  success,
}
