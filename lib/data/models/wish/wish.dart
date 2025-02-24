import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish.freezed.dart';
part 'wish.g.dart';

@freezed
class Wish with _$Wish {
  @JsonSerializable(explicitToJson: true)
  factory Wish({
    required String id,
    required String title,
    required String description,
    @Default([]) List<String?> photos,
    @Default([]) List<String?> links,
    @Default([]) List<String?> geoPoints,
  }) = _Wish;

  factory Wish.fromJson(Map<String, dynamic> json) => _$WishFromJson(json);
}
