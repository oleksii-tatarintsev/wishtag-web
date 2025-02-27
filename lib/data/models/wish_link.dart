import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_link.g.dart';
part 'wish_link.freezed.dart';

@freezed
class WishLink with _$WishLink {
  @JsonSerializable(explicitToJson: true)
  factory WishLink({required String url, required String title}) = _WishLink;

  factory WishLink.fromJson(Map<String, dynamic> json) => _$WishLinkFromJson(json);
}
