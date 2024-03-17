import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(
  String msg,
  Color backgroundColor,
) =>
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      backgroundColor: backgroundColor,
    );

enum ToastState {
  error,
  success,
}
