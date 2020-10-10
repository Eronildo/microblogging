import 'package:intl/intl.dart';

class Message {
  String content;
  final DateTime createdDate;

  final int _maxContentLength = 280;

  Message({this.content, this.createdDate});

  String get formattedDate =>
      DateFormat("dd/MM/yyyy HH:mm", "pt_BR").format(createdDate);

  bool get isValidContent =>
      content != null &&
      content.isNotEmpty &&
      content.length <= _maxContentLength;
}
