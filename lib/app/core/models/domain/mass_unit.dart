import 'package:equatable/equatable.dart';

sealed class Mass extends Equatable {
  final double value;
  const Mass(this.value);
}

class Kilogram extends Mass {
  static const symbol = 'kg';
  const Kilogram(super.value);

  @override
  String toString() {
    return '$value $symbol';
  }

  @override
  List<Object?> get props => [symbol, value];
}

class Pound extends Mass {
  static const symbol = 'lb';
  const Pound(super.value);

  @override
  String toString() {
    return '$value $symbol';
  }

  @override
  List<Object?> get props => [symbol, value];
}
