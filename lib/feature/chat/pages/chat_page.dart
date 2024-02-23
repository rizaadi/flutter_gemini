// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter_gemini/core/widgets/text_field_bottom_widget.dart';
import 'package:flutter_gemini/feature/chat/bloc/chat_bloc.dart';
import 'package:flutter_gemini/feature/chat/pages/widgets/message_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();
    final _scrollController = ScrollController();

    void _scrollDown() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(
            milliseconds: 750,
          ),
          curve: Curves.easeOutCirc,
        ),
      );
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state.status == ChatStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong!'),
                      ),
                    );
                  } else if (state.status == ChatStatus.loaded) {
                    _scrollDown();
                  }
                },
                builder: (context, state) {
                  if (state.status == ChatStatus.initial) {
                    return const SizedBox();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    controller: _scrollController,
                    itemCount: state.chatSession?.history.length ?? 0,
                    itemBuilder: (context, index) {
                      var content = state.chatSession!.history.toList()[index];
                      var text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageWidget(
                        text: text,
                        isFromUser: content.role == 'user',
                      );
                    },
                  );
                },
              ),
            ),
            BlocSelector<ChatBloc, ChatState, ChatStatus>(
              selector: (state) => state.status,
              builder: (context, state) {
                return TextFieldBottomWidget(
                  textController: _textController,
                  isLoading: state == ChatStatus.loading,
                  onFieldSubmitted: () {
                    context
                        .read<ChatBloc>()
                        .add(ChatSendMessage(text: _textController.text));
                    _textController.clear();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
