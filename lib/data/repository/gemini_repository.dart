import 'package:flutter_gemini/core/constans/constants.dart';
import 'package:flutter_gemini/core/services/api_service.dart';
import 'package:flutter_gemini/data/model/candidates/candidates.dart';
import 'package:flutter_gemini/data/model/gemini_response/gemini_response.dart';
import 'package:flutter_gemini/data/model/generation_config/generation_config.dart';
import 'package:flutter_gemini/data/model/safety_setting/safety_setting.dart';

abstract class GeminiRepository {
  Future<Candidates?> textOnly(
    String text, {
    required List<SafetySetting> safetySettings,
    required GenerationConfig generationConfig,
  });
}

class GeminiRepositoryImpl implements GeminiRepository {
  final ApiService api;

  GeminiRepositoryImpl({required this.api});

  @override
  Future<Candidates?> textOnly(
    String text, {
    required List<SafetySetting> safetySettings,
    required GenerationConfig generationConfig,
  }) async {
    final response = await api.post(
      '${Constants.baseUrl}generateContent',
      data: {
        "contents": [
          {
            "parts": [
              {"text": text}
            ]
          }
        ],
        "generationConfig": generationConfig.toJson(),
        "safetySettings": safetySettings
            .map((e) => {
                  'category': e.category.value,
                  'threshold': e.threshold.value,
                })
            .toList()
      },
    );
    print(response);
    return GeminiResponse.fromJson(response.data).candidates?.last;
  }
}
