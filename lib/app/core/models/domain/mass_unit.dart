import 'package:equatable/equatable.dart';

sealed class Mass extends Equatable {
  final double value;
  const Mass(this.value);

  Map<String, dynamic> toJson();
  static Mass fromJson(Map<String, dynamic> json) => switch (json['unit'] as String) {
        'km' => Kilogram((json['value'] as num).toDouble()),
        _ => throw UnimplementedError('Unkonwn unit'),
      };
}

class Kilogram extends Mass {
  static const symbol = 'kg';
  const Kilogram(super.value);

  @override
  Map<String, dynamic> toJson() => {
        'unit': symbol,
        'value': value,
      };

  @override
  List<Object?> get props => [symbol, value];
}

// We'll need the code below when we introduce more mass units.

// class Pound extends Mass {
//   static const symbol = 'lb';
//   const Pound(super.value);

//   @override
//   String toString() {
//     return '$value $symbol';
//   }

//   @override
//   List<Object?> get props => [symbol, value];
// }
