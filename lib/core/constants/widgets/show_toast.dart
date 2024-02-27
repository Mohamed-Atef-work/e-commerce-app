import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg, ToastState toastState) => Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      backgroundColor:
          toastState == ToastState.error ? Colors.red : Colors.green,
    );

enum ToastState {
  error,
  success,
}
