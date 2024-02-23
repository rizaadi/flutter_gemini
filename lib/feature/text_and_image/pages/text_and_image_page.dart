import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:flutter_gemini/feature/text_and_image/bloc/text_and_image_bloc.dart';
import 'package:flutter_gemini/feature/text_and_image/widgets/place_holder_text_and_image.dart';
import 'package:flutter_gemini/core/widgets/text_field_bottom_widget.dart';

class TextAndImagePage extends StatefulWidget {
  const TextAndImagePage({super.key});

  @override
  State<TextAndImagePage> createState() => _TextAndImagePageState();
}

class _TextAndImagePageState extends State<TextAndImagePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<TextAndImageBloc, TextAndImageState>(
                  bloc: context.read<TextAndImageBloc>(),
                  builder: (context, state) {
                    if (state.status == TextAndImageStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == TextAndImageStatus.loaded) {
                      return Markdown(
                        data: state.response!,
                        padding: const EdgeInsets.all(16),
                      );
                    } else if (state.status == TextAndImageStatus.error) {
                      return const Center(
                        child: Text('Something went wrong!'),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              const PlaceHolderTextAndImage(),
              BlocBuilder<TextAndImageBloc, TextAndImageState>(
                builder: (context, state) {
                  return TextFieldBottomWidget(
                    textController: textController,
                    showImagePicker: true,
                    onFieldSubmitted: state.images.isEmpty
                        ? null
                        : () {
                            context.read<TextAndImageBloc>().add(
                                  TextAndImageGenerate(
                                    textController.text,
                                    state.images,
                                  ),
                                );
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
