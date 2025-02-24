import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wishtag_web/data/models/wish_list/wish_list.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserStatus { active, banned }

extension UserExtension on UserStatus {
  String get name {
    switch (this) {
      case UserStatus.active:
        return 'User';
      case UserStatus.banned:
        return 'Banned';
    }
  }
}

extension UserStatusesList on List<UserStatus> {
  List<String> get getStrings {
    final List<String> values = [];
    for (final UserStatus value in this) {
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
    required String userName,
    required String? photoUrl,
    required UserStatus status,
    required int exp,
    @Default(<WishList>[]) List<WishList> wishLists,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
