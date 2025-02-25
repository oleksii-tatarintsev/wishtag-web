import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wishtag_web/data/models/wish/wish.dart';

part 'wish_list.freezed.dart';
part 'wish_list.g.dart';

enum WishListType { public, private, limited }

@freezed
class WishList with _$WishList {
  @JsonSerializable(explicitToJson: true)
  factory WishList({
    required String id,
    required String title,
    required String description,
    required WishListType type,
    @Default([]) List<String?> allowedUsers,
    @Default(<Wish>[]) List<Wish?> wishes,
  }) = _WishList;

  factory WishList.fromJson(Map<String, dynamic> json) => _$WishListFromJson(json);
}

extension WishListExt on WishListType {
  String get name {
    switch (this) {
      case WishListType.public:
        return 'Public';
      case WishListType.private:
        return 'Private';
      case WishListType.limited:
        return 'Limited';
    }
  }
}

extension WishListsValues on List<WishListType> {
  List<String> get getStrings {
    final List<String> values = [];
    for (final WishListType value in this) {
      values.add(value.name);
    }
    return values;
  }
}
