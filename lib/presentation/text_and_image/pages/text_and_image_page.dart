
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/presentation/text_and_image/bloc/text_and_image_bloc.dart';
import 'package:flutter_gemini/presentation/widgets/text_field_bottom_widget.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
              BlocBuilder<TextAndImageBloc, TextAndImageState>(
                
                builder: (context, state) {
                  print('build build $state');
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
                        child: child,
                      );
                    },
                    child: Column(
                      children: [
                        if (state.images.isNotEmpty)
                          Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, -1),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.images.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        state.images[index],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<TextAndImageBloc>().add(RemoveImage(index));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              TextFieldBottomWidget(
                textController: textController,
                onFieldSubmitted: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
