sealed class Mass {
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
}

class Pound extends Mass {
  static const symbol = 'lb';
  const Pound(super.value);

  @override
  String toString() {
    return '$value $symbol';
  }
}
