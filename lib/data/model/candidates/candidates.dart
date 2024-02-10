import 'package:flutter_gemini/data/model/content/content.dart';
import 'package:flutter_gemini/data/model/safety_ratings/safety_ratings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidates.freezed.dart';
part 'candidates.g.dart';

@unfreezed
class Candidates with _$Candidates {
  factory Candidates({
    Content? content,
    String? finishReason,
    int? index,
    List<SafetyRatings>? safetyRatings,
  }) = _Candidates;

  factory Candidates.fromJson(Map<String, dynamic> json) =>
      _$CandidatesFromJson(json);
}
