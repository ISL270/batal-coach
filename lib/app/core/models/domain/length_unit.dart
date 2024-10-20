import 'package:equatable/equatable.dart';

sealed class Length extends Equatable {
  final double value;
  const Length(this.value);

  Map<String, dynamic> toJson();
  static Length fromJson(Map<String, dynamic> json) => switch (json['unit'] as String) {
        'km' => Kilometer((json['value'] as num).toDouble()),
        _ => throw Exception('Unkonwn length unit'),
      };
}

class Kilometer extends Length {
  static const symbol = 'km';
  const Kilometer(super.value);

  @override
  Map<String, dynamic> toJson() => {
        'unit': symbol,
        'value': value,
      };

  @override
  List<Object?> get props => [symbol, value];
}

// We'll need the code below when we introduce more length units.

// class Meter extends Length {
//   const Meter(super.value);

//   @override
//   Map<String, dynamic> toJson() => {
//         'unit': LengthUnit.m.name,
//         'value': value,
//       };
// }

// class Mile extends Length {
//   const Mile(super.value);

//   @override
//   Map<String, dynamic> toJson() => {
//         'unit': LengthUnit.mi.name,
//         'value': value,
//       };
// }

// enum LengthUnit {
//   /// Kilometer
//   km,

//   /// Meter
//   m,

//   /// Mile
//   mi,
// }
