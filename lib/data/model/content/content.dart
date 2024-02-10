import 'package:flutter_gemini/data/model/parts/parts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@unfreezed
class Content with _$Content {
  factory Content({
    List<Parts>? parts,
    String? role,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
