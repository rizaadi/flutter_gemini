part of 'text_only_bloc.dart';

enum TextOnlyStatus {
  initial,
  loading,
  loaded,
  error,
}

class TextOnlyState extends Equatable {
  final TextOnlyStatus status;
  final String? prompt;
  final String? response;

  const TextOnlyState({
    required this.status,
    required this.prompt,
    required this.response,
  });

  static TextOnlyState initial() => const TextOnlyState(
        status: TextOnlyStatus.initial,
        prompt: null,
        response: null,
      );

  TextOnlyState copyWith({
    TextOnlyStatus? status,
    String? prompt,
    String? response,
  }) {
    return TextOnlyState(
      status: status ?? this.status,
      prompt: prompt ?? this.prompt,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [status, prompt, response];
}
