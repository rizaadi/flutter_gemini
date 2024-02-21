import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/data/model/generation_config/generation_config.dart';
import 'package:flutter_gemini/data/model/safety_setting/safety_setting.dart';
import 'package:flutter_gemini/data/model/safety_setting/safety_setting_category.dart';
import 'package:flutter_gemini/data/model/safety_setting/safety_setting_threshold.dart';
import 'package:flutter_gemini/data/repository/gemini_repository.dart';

part 'text_only_event.dart';
part 'text_only_state.dart';

class TextOnlyBloc extends Bloc<TextOnlyEvent, TextOnlyState> {
  final GeminiRepository geminiRepository;

  TextOnlyBloc({required this.geminiRepository})
      : super(TextOnlyState.initial()) {
    on<TextOnlyGenerate>((event, emit) async {
      try {
        emit(state.copyWith(status: TextOnlyStatus.loading));

        final response = await geminiRepository.textOnly(
          event.text,
          safetySettings: [
            SafetySetting(
              category: SafetyCategory.harassment,
              threshold: SafetyThreshold.blockMediumAndAbove,
            ),
            SafetySetting(
              category: SafetyCategory.hateSpeech,
              threshold: SafetyThreshold.blockMediumAndAbove,
            ),
            SafetySetting(
              category: SafetyCategory.sexuallyExplicit,
              threshold: SafetyThreshold.blockMediumAndAbove,
            ),
            SafetySetting(
              category: SafetyCategory.dangerous,
              threshold: SafetyThreshold.blockMediumAndAbove,
            ),
          ],
          generationConfig: GenerationConfig(
            temperature: 0.9,
            topK: 1,
            topP: 1,
            maxOutputTokens: 2048,
            stopSequences: [],
          ),
        );
        emit(state.copyWith(
          status: TextOnlyStatus.loaded,
          response: response!.content!.parts!.first.text!,
        ));
      } catch (e) {
        emit(state.copyWith(status: TextOnlyStatus.error));
      }
    });
  }
}
