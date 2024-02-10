import 'package:freezed_annotation/freezed_annotation.dart';

part 'safety_ratings.freezed.dart';
part 'safety_ratings.g.dart';

@unfreezed
class SafetyRatings with _$SafetyRatings {
  factory SafetyRatings({
    String? category,
    String? probability,
  }) = _SafetyRatings;

  factory SafetyRatings.fromJson(Map<String, dynamic> json) =>
      _$SafetyRatingsFromJson(json);
}
