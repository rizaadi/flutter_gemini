import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:flutter_gemini/feature/text_only/bloc/text_only_bloc.dart';
import 'package:flutter_gemini/feature/widgets/text_field_bottom_widget.dart';

class TextOnlyPage extends StatefulWidget {
  const TextOnlyPage({super.key});

  @override
  State<TextOnlyPage> createState() => _TextOnlyPageState();
}

class _TextOnlyPageState extends State<TextOnlyPage> {
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
                child: BlocBuilder<TextOnlyBloc, TextOnlyState>(
                  bloc: context.read<TextOnlyBloc>(),
                  builder: (context, state) {
                    if (state.status == TextOnlyStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == TextOnlyStatus.loaded) {
                      return Markdown(
                        data: state.response!,
                        padding: const EdgeInsets.all(16),
                      );
                    } else if (state.status == TextOnlyStatus.error) {
                      return const Center(
                        child: Text('Something went wrong!'),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              BlocSelector<TextOnlyBloc, TextOnlyState, String?>(
                bloc: context.read<TextOnlyBloc>(),
                selector: (state) {
                  return state.prompt;
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(0, 1), end: Offset.zero)
                            .animate(animation),
                        child: child,
                      );
                    },
                    child: state == null
                        ? const SizedBox()
                        : Container(
                            key: ValueKey(state),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, -1),
                                ),
                              ],
                            ),
                            child: Text(
                              state,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  );
                },
              ),
              TextFieldBottomWidget(
                textController: textController,
                onFieldSubmitted: () {
                  context
                      .read<TextOnlyBloc>()
                      .add(TextOnlyGenerate(textController.text));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
