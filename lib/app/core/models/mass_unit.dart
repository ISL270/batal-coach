sealed class Mass {
  const Mass();
}

class Kilogram extends Mass {
  final double value;
  static const symbol = 'kg';
  const Kilogram(this.value);
}

class Pound extends Mass {
  final double value;
  static const symbol = 'lb';
  const Pound(this.value);
}
