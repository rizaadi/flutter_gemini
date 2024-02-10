import 'package:flutter_gemini/data/model/candidates/candidates.dart';
import 'package:flutter_gemini/data/model/prompt_feedback/prompt_feedback.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gemini_response.freezed.dart';
part 'gemini_response.g.dart';

@unfreezed
class GeminiResponse with _$GeminiResponse {
  factory GeminiResponse({
    List<Candidates>? candidates,
    PromptFeedback? promptFeedback,
  }) = _GeminiResponse;

  factory GeminiResponse.fromJson(Map<String, dynamic> json) =>
      _$GeminiResponseFromJson(json);
}
