import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool isOutLined;

  const CustomFlatButton({
    Key key,
    this.onPressed,
    this.buttonText,
    this.isOutLined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 45.0,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 15.0, letterSpacing: 2.0, fontWeight: FontWeight.bold),
        ),
        color: isOutLined ? Colors.transparent : Get.theme.accentColor,
        textColor: isOutLined ? Get.theme.accentColor : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blue, width: 1, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
