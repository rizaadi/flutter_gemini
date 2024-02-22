import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

abstract class GeminiRepository {
  Future<GenerateContentResponse> textOnly(String text);
  Future<GenerateContentResponse> textAndImage(String text, List<File> images);
}
