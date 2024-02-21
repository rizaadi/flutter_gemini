import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter_gemini/core/utils/api_key.dart';
import 'package:flutter_gemini/data/repository/gemini_repository.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  @override
  Future<GenerateContentResponse> textOnly(String text) async {
    final apiKey = ApiKey().getApiKey();

    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );

    final response = await model.generateContent([Content.text(text)]);
    return response;
  }
}
