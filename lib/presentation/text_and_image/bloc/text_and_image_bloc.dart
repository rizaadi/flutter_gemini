import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/data/repository/gemini_repository.dart';

part 'text_and_image_event.dart';
part 'text_and_image_state.dart';

class TextAndImageBloc extends Bloc<TextAndImageEvent, TextAndImageState> {
  final GeminiRepository geminiRepository;

  TextAndImageBloc({required this.geminiRepository})
      : super(TextAndImageState.initial()) {
    on<TextAndImageEvent>((event, emit) {
      try {} catch (e) {}
    });

    on<AddImage>((event, emit) {
      final images = [...state.images, ...event.image];
      emit(state.copyWith(images: images));
    });
    on<RemoveImage>((event, emit) {
      if (state.images.isEmpty) return;
      final List<File> images = List.from(state.images)
        ..removeAt(event.indexImage);
      emit(state.copyWith(images: images));
    });
  }
}
