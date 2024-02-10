// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenerationConfigImpl _$$GenerationConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$GenerationConfigImpl(
      temperature: (json['temperature'] as num?)?.toDouble(),
      topK: json['topK'] as int?,
      topP: (json['topP'] as num?)?.toDouble(),
      maxOutputTokens: json['maxOutputTokens'] as int?,
      stopSequences: (json['stopSequences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$GenerationConfigImplToJson(
        _$GenerationConfigImpl instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'topK': instance.topK,
      'topP': instance.topP,
      'maxOutputTokens': instance.maxOutputTokens,
      'stopSequences': instance.stopSequences,
    };
