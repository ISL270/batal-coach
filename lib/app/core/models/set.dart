sealed class Set {
  final int value;
  const Set(this.value);

  Set copyWith(int value);
}

class Regular extends Set {
  const Regular(super.value);
  factory Regular.first() => const Regular(1);

  @override
  Regular copyWith(int value) => Regular(value);
}

class WarmUp extends Set {
  const WarmUp(super.value);
  factory WarmUp.first() => const WarmUp(1);

  @override
  WarmUp copyWith(int value) => WarmUp(value);
}

class DropSet extends Set {
  const DropSet(super.value);
  factory DropSet.first() => const DropSet(1);

  @override
  DropSet copyWith(int value) => DropSet(value);
}

class Failure extends Set {
  const Failure(super.value);
  factory Failure.first() => const Failure(1);

  @override
  Failure copyWith(int value) => Failure(value);
}
