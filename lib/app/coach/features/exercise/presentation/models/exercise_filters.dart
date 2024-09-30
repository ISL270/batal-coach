import 'package:btl/app/coach/features/exercise/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_ownership.dart';
import 'package:btl/app/coach/features/exercise/domain/models/muscle.dart';

final class ExFilters {
  Set<ExOwnership> owership = {ExOwnership.btl, ExOwnership.custom};
  final Set<Muscle> muscles = {};
  final Set<Equipment> equipment = {};
  final Set<ExCategory> category = {};
  final Set<ExLevel> level = {};
}
