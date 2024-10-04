sealed class Length {
  const Length();
}

class Meter extends Length {
  final double value;
  static const symbol = 'm';
  const Meter(this.value);
}

class Kilometer extends Length {
  final double value;
  static const symbol = 'km';
  const Kilometer(this.value);
}
