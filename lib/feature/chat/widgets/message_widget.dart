import 'package:flutter/material.dart';
import 'package:flutter_gemini/core/enums/message_type.dart';
import 'package:flutter_gemini/feature/chat/models/message_model.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;

  const MessageWidget({
    super.key,
    required this.message,
  });

  bool _isFromUser() {
    return message.role == MessageType.user;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _isFromUser() ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
          decoration: BoxDecoration(
            color: _isFromUser()
                ? Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft:
                  _isFromUser() ? const Radius.circular(16) : Radius.zero,
              bottomRight:
                  _isFromUser() ? Radius.zero : const Radius.circular(16),
            ),
            border: _isFromUser()
                ? null
                : Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 8),
          child: MarkdownBody(
            selectable: true,
            data: message.text,
          ),
        ),
      ],
    );
  }
}
