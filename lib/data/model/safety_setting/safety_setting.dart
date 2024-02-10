import 'package:flutter_gemini/data/model/safety_setting/safety_setting_category.dart';
import 'package:flutter_gemini/data/model/safety_setting/safety_setting_threshold.dart';

class SafetySetting {
  final SafetyCategory category;
  final SafetyThreshold threshold;

  SafetySetting({
    required this.category,
    required this.threshold,
  });
}
