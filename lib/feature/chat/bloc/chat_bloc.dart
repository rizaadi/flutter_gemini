import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter_gemini/core/enums/message_type.dart';
import 'package:flutter_gemini/feature/chat/models/message_model.dart';
import 'package:flutter_gemini/feature/gemini/repository/gemini_repository_impl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GeminiRepositoryImpl geminiRepository;

  ChatBloc({required this.geminiRepository}) : super(ChatState.initial()) {
    List<MessageModel> messages = [];

    on<ChatSendMessage>((event, emit) async {
      try {
        messages = List.from(state.messages)
          ..add(MessageModel(
            text: event.text,
            role: MessageType.user,
          ));

        emit(state.copyWith(
          status: ChatStatus.loading,
          messages: messages,
        ));

        final (chatSession, text) = await geminiRepository.chat(
          event.text,
          state.chatSession,
        );

        messages = List.from(state.messages)
          ..add(MessageModel(
            text: text,
            role: MessageType.model,
          ));
        emit(state.copyWith(
          status: ChatStatus.loaded,
          chatSession: chatSession,
          messages: messages,
        ));
      } catch (e) {
        emit(state.copyWith(status: ChatStatus.error));
      }
    });
  }
}
