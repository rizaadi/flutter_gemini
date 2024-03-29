import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_gemini/feature/text_and_image/bloc/text_and_image_bloc.dart';

class TextFieldBottomWidget extends StatefulWidget {
  const TextFieldBottomWidget({
    super.key,
    required this.textController,
    required this.onFieldSubmitted,
    this.showImagePicker = false,
    this.isLoading = false,
  });

  final TextEditingController textController;
  final VoidCallback? onFieldSubmitted;
  final bool showImagePicker;
  final bool isLoading;

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
          if (widget.showImagePicker)
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final image = await picker.pickMultiImage();
                if (image.isEmpty) return;

                // ignore: use_build_context_synchronously
                context.read<TextAndImageBloc>().add(AddImage(image.map((e) => File(e.path)).toList()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.image_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
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
                  widget.onFieldSubmitted!();
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
          if (widget.isLoading)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            )
          else
            GestureDetector(
              onTap: widget.onFieldSubmitted == null || widget.textController.text.isEmpty
                  ? null
                  : () {
                      widget.onFieldSubmitted!();
                      setState(() {
                        widget.textController.clear();
                      });
                    },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.send_rounded,
                  color: widget.onFieldSubmitted == null || widget.textController.text.isEmpty
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            )
        ],
      ),
    );
  }
}
