import 'package:equatable/equatable.dart';

sealed class Length extends Equatable {
  final double value;
  const Length(this.value);
}

class Meter extends Length {
  static const symbol = 'm';
  const Meter(super.value);

  @override
  String toString() {
    return '$value $symbol';
  }

  @override
  List<Object?> get props => [symbol, value];
}

class Kilometer extends Length {
  static const symbol = 'km';
  const Kilometer(super.value);

  @override
  String toString() {
    return '$value $symbol';
  }

  @override
  List<Object?> get props => [symbol, value];
}
