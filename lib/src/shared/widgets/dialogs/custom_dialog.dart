import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String contentText;
  final String confirmText;
  final bool showCancelButton;
  final String cancelText;
  final VoidCallback onConfirmPressed;
  final VoidCallback onCancelPressed;

  const CustomDialog({
    Key key,
    this.contentText = '',
    this.confirmText = 'CONFIRM',
    this.cancelText = 'CANCEL',
    this.showCancelButton = true,
    this.onConfirmPressed,
    this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        contentText,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        Visibility(
          visible: showCancelButton,
          child: FlatButton(
            child: Text(
              cancelText,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: onCancelPressed ??
                () {
                  Get.back();
                },
          ),
        ),
        FlatButton(
          child: Text(
            confirmText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: onConfirmPressed ??
              () {
                Get.back();
              },
        ),
      ],
    );
  }
}
