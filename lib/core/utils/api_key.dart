import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  static const String _apiKey = 'GEMINI_KEY';

  String getApiKey() => dotenv.get(_apiKey);
}
