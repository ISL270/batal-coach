import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:equatable/equatable.dart';

final class ExFilters with EquatableMixin {
  final Set<ExOwnership> owership = {ExOwnership.btl, ExOwnership.personal};
  final Set<Muscle> muscles = {};
  final Set<Equipment> equipments = {};
  final Set<ExType> types = {};
  final Set<ExLevel> levels = {};

  bool get isEmpty =>
      owership.length == 2 &&
      muscles.isEmpty &&
      equipments.isEmpty &&
      types.isEmpty &&
      levels.isEmpty;

  @override
  List<Object?> get props => [
        owership,
        muscles,
        equipments,
        types,
        levels,
      ];

  ExFilters clone() {
    return ExFilters()
      ..owership.addAll(owership)
      ..muscles.addAll(muscles)
      ..equipments.addAll(equipments)
      ..types.addAll(types)
      ..levels.addAll(levels);
  }
}
