import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter_gemini/feature/gemini/repository/gemini_repository_impl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GeminiRepositoryImpl geminiRepository;

  ChatBloc({required this.geminiRepository}) : super(ChatState.initial()) {
    on<ChatSendMessage>((event, emit) async {
      try {
        emit(state.copyWith(status: ChatStatus.loading));

        final chatSession =
            await geminiRepository.chat(event.text, state.chatSession);

        emit(state.copyWith(
            status: ChatStatus.loaded, chatSession: chatSession));
      } catch (e) {
        emit(state.copyWith(status: ChatStatus.error));
      }
    });
  }
}
