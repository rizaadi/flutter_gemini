import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/feature/gemini/repository/gemini_repository_impl.dart';

part 'text_and_image_event.dart';
part 'text_and_image_state.dart';

class TextAndImageBloc extends Bloc<TextAndImageEvent, TextAndImageState> {
  final GeminiRepositoryImpl geminiRepository;

  TextAndImageBloc({required this.geminiRepository})
      : super(TextAndImageState.initial()) {
    on<TextAndImageGenerate>((event, emit) async {
      try {
        emit(state.copyWith(
          status: TextAndImageStatus.loading,
          prompt: event.text,
        ));

        final response =
            await geminiRepository.textAndImage(event.text, event.images);

        emit(state.copyWith(
          status: TextAndImageStatus.loaded,
          response: response.text,
        ));
      } catch (e) {
        emit(state.copyWith(status: TextAndImageStatus.error));
      }
    });

    on<AddImage>((event, emit) {
      final images = [...state.images, ...event.image];
      emit(state.copyWith(images: images));
    });
    on<RemoveImage>((event, emit) {
      if (state.images.isEmpty) return;

      final List<File> images = List.from(state.images)
        ..removeAt(event.indexImage);
      if (images.isEmpty) {
        emit(state.copyWith(prompt: '', images: images));
      } else {
        emit(state.copyWith(images: images));
      }
    });
  }
}
