part of 'text_and_image_bloc.dart';

enum TextAndImageStatus {
  initial,
  loading,
  loaded,
  error,
}

class TextAndImageState extends Equatable {
  final TextAndImageStatus status;
  final String? prompt;
  final List<File> images;
  final String? response;

  const TextAndImageState({
    required this.status,
    required this.prompt,
    required this.images,
    required this.response,
  });

  static TextAndImageState initial() => const TextAndImageState(
        status: TextAndImageStatus.initial,
        prompt: null,
        images: [],
        response: null,
      );

  TextAndImageState copyWith({
    TextAndImageStatus? status,
    String? prompt,
    List<File>? images,
    String? response,
  }) {
    return TextAndImageState(
      status: status ?? this.status,
      prompt: prompt ?? this.prompt,
      images: images ?? this.images,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [status, prompt, images, response];
}
