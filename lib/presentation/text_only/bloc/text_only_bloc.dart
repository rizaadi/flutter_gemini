import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/data/repository/gemini_repository_impl.dart';

part 'text_only_event.dart';
part 'text_only_state.dart';

class TextOnlyBloc extends Bloc<TextOnlyEvent, TextOnlyState> {
  final GeminiRepositoryImpl geminiRepository;

  TextOnlyBloc({required this.geminiRepository})
      : super(TextOnlyState.initial()) {
    on<TextOnlyGenerate>((event, emit) async {
      try {
        emit(state.copyWith(
          prompt: event.text,
          status: TextOnlyStatus.loading,
        ));

        final response = await geminiRepository.textOnly(event.text);

        emit(state.copyWith(
          status: TextOnlyStatus.loaded,
          response: response.text,
        ));
      } catch (e) {
        emit(state.copyWith(status: TextOnlyStatus.error));
      }
    });
  }
}
