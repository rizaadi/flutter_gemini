import 'package:flutter_gemini/data/model/safety_ratings/safety_ratings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt_feedback.freezed.dart';
part 'prompt_feedback.g.dart';

@unfreezed
class PromptFeedback with _$PromptFeedback {
  factory PromptFeedback({
    List<SafetyRatings>? safetyRatings,
  }) = _PromptFeedback;

  factory PromptFeedback.fromJson(Map<String, dynamic> json) =>
      _$PromptFeedbackFromJson(json);
}
