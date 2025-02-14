import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole { admin, support, user, banned }

extension UserExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.support:
        return 'Support';
      case UserRole.user:
        return 'User';
      case UserRole.banned:
        return 'Banned';
    }
  }
}

extension UserRolesList on List<UserRole> {
  List<String> get getStrings {
    final List<String> values = [];
    for (final UserRole value in this) {
      values.add(value.name);
    }
    return values;
  }
}

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required String id,
    required String name,
    required String email,
    required String? photoUrl,
    required UserRole role,
    required int exp,
    required List<String?> publicWishes,
    required List<String?> privateWishes,
    required List<String?> limitedWishes,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
