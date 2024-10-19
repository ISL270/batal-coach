import 'package:equatable/equatable.dart';

enum LengthUnit { m, km }

sealed class Length extends Equatable {
  final double value;
  const Length(this.value);

  Map<String, dynamic> toJson();
  static Length fromJson(Map<String, dynamic> json) => switch (json['unit'] as String) {
        'm' => Meter((json['value'] as num).toDouble()),
        'km' => Kilometer((json['value'] as num).toDouble()),
        _ => throw UnimplementedError('Unkonw unit'),
      };

  @override
  List<Object?> get props => [value];
}

class Meter extends Length {
  const Meter(super.value);

  @override
  Map<String, dynamic> toJson() => {
        'unit': LengthUnit.m.name,
        'value': value,
      };
}

class Kilometer extends Length {
  const Kilometer(super.value);

  @override
  Map<String, dynamic> toJson() => {
        'type': LengthUnit.km.name,
        'value': value,
      };
}
