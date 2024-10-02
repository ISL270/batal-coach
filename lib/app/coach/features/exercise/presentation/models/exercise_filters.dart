import 'package:btl/app/coach/features/exercise/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_ownership.dart';
import 'package:btl/app/coach/features/exercise/domain/models/muscle.dart';
import 'package:equatable/equatable.dart';

final class ExFilters with EquatableMixin {
  final Set<ExOwnership> owership = {ExOwnership.btl, ExOwnership.personal};
  final Set<Muscle> muscles = {};
  final Set<Equipment> equipment = {};
  final Set<ExCategory> category = {};
  final Set<ExLevel> level = {};

  bool get isEmpty =>
      owership.length == 2 &&
      muscles.isEmpty &&
      equipment.isEmpty &&
      category.isEmpty &&
      level.isEmpty;

  @override
  List<Object?> get props => [
        owership,
        muscles,
        equipment,
        category,
        level,
      ];

  ExFilters clone() {
    return ExFilters()
      ..owership.addAll(owership)
      ..muscles.addAll(muscles)
      ..equipment.addAll(equipment)
      ..category.addAll(category)
      ..level.addAll(level);
  }
}
