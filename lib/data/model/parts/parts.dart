import 'package:freezed_annotation/freezed_annotation.dart';

part 'parts.freezed.dart';
part 'parts.g.dart';

@unfreezed
class Parts with _$Parts {
  factory Parts({
    String? text,
  }) = _Parts;

  factory Parts.fromJson(Map<String, dynamic> json) => _$PartsFromJson(json);
}
