import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter_gemini/core/utils/api_key.dart';
import 'package:flutter_gemini/feature/gemini/repository/gemini_repository.dart';

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

  @override
  Future<GenerateContentResponse> textAndImage(
      String text, List<File> images) async {
    final apiKey = ApiKey().getApiKey();

    final model = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: apiKey,
    );

    final dataParts = await Future.wait(
      images.map((file) async {
        return DataPart('image/jpeg', await file.readAsBytes());
      }).toList(),
    );

    final content = [
      Content.multi([
        TextPart(text),
        ...dataParts,
      ])
    ];

    final response = await model.generateContent(content);
    return response;
  }
}
