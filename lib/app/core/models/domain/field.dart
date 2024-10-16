import 'package:btl/app/core/models/domain/length_unit.dart';
import 'package:btl/app/core/models/domain/mass_unit.dart';
import 'package:equatable/equatable.dart';

sealed class Field extends Equatable {
  const Field();
}

class Time extends Field {
  final Duration value;
  const Time(this.value);

  factory Time.zero() => const Time(Duration.zero);

  @override
  List<Object?> get props => [value];
}

class Distance extends Field {
  final Length value;
  const Distance(this.value);

  factory Distance.zero() => const Distance(Meter(0));

  @override
  List<Object?> get props => [value];
}

class Weight extends Field {
  final Mass value;
  const Weight(this.value);

  factory Weight.zero() => const Weight(Kilogram(0));

  @override
  List<Object?> get props => [value];
}

class Reps extends Field {
  final int value;
  const Reps(this.value);
  factory Reps.zero() => const Reps(0);

  @override
  List<Object?> get props => [value];
}

extension FieldX on Field {
  bool get isTime => this is Time;
  bool get isDistance => this is Distance;
  bool get isWeight => this is Weight;
  bool get isReps => this is Reps;
}
