import 'package:flutter/material.dart';

modelSheet(
  BuildContext context,
  Widget widget,
) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) => widget,
  );
}
