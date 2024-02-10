import 'package:freezed_annotation/freezed_annotation.dart';

part 'generation_config.freezed.dart';
part 'generation_config.g.dart';

@unfreezed
class GenerationConfig with _$GenerationConfig {
  factory GenerationConfig({
    double? temperature,
    int? topK,
    double? topP,
    int? maxOutputTokens,
    List<String>? stopSequences,
  }) = _GenerationConfig;

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigFromJson(json);
}
