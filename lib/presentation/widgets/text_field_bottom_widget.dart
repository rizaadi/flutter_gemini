import 'package:flutter/material.dart';

class TextFieldBottomWidget extends StatefulWidget {
  const TextFieldBottomWidget({
    super.key,
    required this.textController,
    required this.onFieldSubmitted,
  });

  final TextEditingController textController;
  final VoidCallback onFieldSubmitted;

  @override
  State<TextFieldBottomWidget> createState() => _TextFieldBottomWidgetState();
}

class _TextFieldBottomWidgetState extends State<TextFieldBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              child: TextFormField(
                controller: widget.textController,
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                onChanged: (value) {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  widget.onFieldSubmitted();
                  widget.textController.clear();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: 'Type something...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.textController.text.isEmpty
                ? null
                : () {
                    widget.onFieldSubmitted();
                    widget.textController.clear();
                  },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.send_rounded,
                color: widget.textController.text.isEmpty ? Colors.grey : Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
