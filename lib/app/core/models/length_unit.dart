sealed class Length {
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
}

class Kilometer extends Length {
  static const symbol = 'km';
  const Kilometer(super.value);

  @override
  String toString() {
    return '$value $symbol';
  }
}
