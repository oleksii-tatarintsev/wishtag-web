import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required String id,
    required String name,
    required String email,
    required String? photoUrl,
    required String status,
    required int exp,
    required List<String?> publicWishes,
    required List<String?> privateWishes,
    required List<String?> limitedWishes,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
