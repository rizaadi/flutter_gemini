part of 'chat_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  error,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final ChatSession? chatSession;

  const ChatState({
    required this.status,
    this.chatSession,
  });

  ChatState copyWith({
    ChatStatus? status,
    ChatSession? chatSession,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatSession: chatSession ?? this.chatSession,
    );
  }

  static ChatState initial() => const ChatState(
        status: ChatStatus.initial,
        chatSession: null,
      );

  @override
  List<Object?> get props => [status, chatSession];
}
