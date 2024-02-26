import 'package:flutter_gemini/core/enums/message_type.dart';

class MessageModel {
  final String text;
  final MessageType role;

  MessageModel({
    required this.text,
    required this.role,
  });
}
