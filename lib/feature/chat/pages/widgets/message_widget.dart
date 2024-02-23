import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
          decoration: BoxDecoration(
            color: isFromUser
                ? Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isFromUser ? const Radius.circular(16) : Radius.zero,
              bottomRight: isFromUser ? Radius.zero : const Radius.circular(16),
            ),
            border: isFromUser
                ? null
                : Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 8),
          child: MarkdownBody(
            selectable: true,
            data: text,
          ),
        ),
      ],
    );
  }
}
