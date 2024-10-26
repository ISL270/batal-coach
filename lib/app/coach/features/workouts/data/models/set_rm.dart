import 'package:btl/app/core/models/domain/set.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_rm.g.dart';

@JsonSerializable()
final class SetRM {
  final String type;
  final int value;

  const SetRM(this.type, this.value);

  factory SetRM.fromDomain(SET set) => SetRM(
        switch (set) {
          Regular() => Regular.key,
        },
        set.value,
      );

  SET toDomain() => switch (type) {
        Regular.key => Regular(value),
        _ => throw UnimplementedError('Unkonwn set type'),
      };

  factory SetRM.fromJson(Map<String, dynamic> json) => _$SetRMFromJson(json);

  Map<String, dynamic> toJson() => _$SetRMToJson(this);
}
