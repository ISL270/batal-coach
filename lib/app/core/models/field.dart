import 'package:btl/app/core/models/length_unit.dart';
import 'package:btl/app/core/models/mass_unit.dart';

sealed class Field {
  const Field();
}

class Time extends Field {
  final Duration value;
  const Time(this.value);

  factory Time.zero() => const Time(Duration.zero);
}

class Distance extends Field {
  final Length value;
  const Distance(this.value);

  factory Distance.zero() => const Distance(Meter(0));
}

class Weight extends Field {
  final Mass value;
  const Weight(this.value);

  factory Weight.zero() => const Weight(Kilogram(0));
}

class Reps extends Field {
  final int value;
  const Reps(this.value);
  factory Reps.zero() => const Reps(0);
}

extension FieldX on Field {
  bool get isTime => this is Time;
  bool get isDistance => this is Distance;
  bool get isWeight => this is Weight;
  bool get isReps => this is Reps;
}
