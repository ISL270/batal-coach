sealed class SET {
  final int value;
  const SET(this.value);

  SET copyWith(int value);
}

class Regular extends SET {
  const Regular(super.value);
  factory Regular.first() => const Regular(1);

  @override
  Regular copyWith(int value) => Regular(value);
}

class WarmUp extends SET {
  const WarmUp(super.value);
  factory WarmUp.first() => const WarmUp(1);

  @override
  WarmUp copyWith(int value) => WarmUp(value);
}

class DropSet extends SET {
  const DropSet(super.value);
  factory DropSet.first() => const DropSet(1);

  @override
  DropSet copyWith(int value) => DropSet(value);
}

class Failure extends SET {
  const Failure(super.value);
  factory Failure.first() => const Failure(1);

  @override
  Failure copyWith(int value) => Failure(value);
}
