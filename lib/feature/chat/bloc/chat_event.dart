part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatSendMessage extends ChatEvent {
  final String text;
  const ChatSendMessage({required this.text});

  @override
  List<Object> get props => [text];
}
