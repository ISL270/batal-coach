part of 'workout_builder_cubit.dart';

typedef WorkoutStatus = Status<Workout>;

final class WorkoutBuilderState extends Equatable {
  final String name;
  final Optional<String> description;
  final bool reordering;
  final List<ExerciseSets> exercisesSets;
  final WorkoutStatus status;

  const WorkoutBuilderState({
    this.exercisesSets = const [],
    this.name = '',
    this.description = const Optional.absent(),
    this.reordering = false,
    this.status = const Initial(),
  });

  WorkoutBuilderState copyWith({
    List<ExerciseSets>? exercisesSets,
    String? name,
    Optional<String>? description,
    bool? reordering,
    WorkoutStatus? status,
  }) {
    return WorkoutBuilderState(
      exercisesSets: exercisesSets ?? this.exercisesSets,
      name: name ?? this.name,
      description: description ?? this.description,
      reordering: reordering ?? this.reordering,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        exercisesSets,
        reordering,
        name,
        description,
        status,
      ];
}

extension _EexerciseSetsX on ExerciseSets {
  ExerciseSets removeSet(SET set) {
    final fieldsClone = Map<SET, List<Field>>.from(fields)..remove(set);
    final newFields = <SET, List<Field>>{};
    for (var i = 0; i < fieldsClone.length; i++) {
      newFields[fieldsClone.entries.elementAt(i).key.copyWith(i + 1)] =
          fieldsClone.entries.elementAt(i).value;
    }
    return ExerciseSets(exercise, fields: newFields);
  }

  ExerciseSets addSet() {
    return ExerciseSets(
      exercise,
      fields: Map.from(fields)..[Regular(fields.keys.last.value + 1)] = exercise.initialFields(),
    );
  }

  ExerciseSets updateField<F extends Field>(SET set, F field) {
    final fieldsClone = List<Field>.from(fields[set]!);
    final i = fieldsClone.indexWhere((f) => f is F);
    fieldsClone[i] = field;
    return ExerciseSets(
      exercise,
      fields: Map<SET, List<Field>>.from(fields)..update(set, (_) => fieldsClone),
    );
  }
}
