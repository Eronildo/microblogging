import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostOption {
  final VoidCallback onPressed;
  final String name;
  final IconData iconData;

  PostOption(
      {@required this.onPressed, @required this.name, @required this.iconData});
}
