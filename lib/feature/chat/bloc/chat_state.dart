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
  final List<MessageModel> messages;

  const ChatState({
    required this.status,
    this.chatSession,
    required this.messages,
  });

  ChatState copyWith({
    ChatStatus? status,
    ChatSession? chatSession,
    List<MessageModel>? messages,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatSession: chatSession ?? this.chatSession,
      messages: messages ?? this.messages,
    );
  }

  static ChatState initial() => const ChatState(
        status: ChatStatus.initial,
        chatSession: null,
        messages: [],
      );

  @override
  List<Object?> get props => [status, chatSession, messages];
}
