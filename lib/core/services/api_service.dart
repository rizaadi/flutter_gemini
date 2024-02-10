import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/core/constans/constants.dart';

class ApiService {
  late String apiKey;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    contentType: 'application/json',
  ));

  ApiService() {
    apiKey = dotenv.get('GEMINI_KEY');
  }

  Future<Response> post(
    String path, {
    required Map<String, Object>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: jsonEncode(data),
        queryParameters: {'key': apiKey},
      );

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }
}
