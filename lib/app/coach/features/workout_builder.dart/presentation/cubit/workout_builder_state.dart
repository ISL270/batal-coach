part of 'workout_builder_cubit.dart';

final class WorkoutBuilderState extends Equatable {
  final List<ExerciseDetails> exercises;
  final String name;
  final bool reordering;
  const WorkoutBuilderState({this.exercises = const [], this.name = '', this.reordering = false});

  WorkoutBuilderState copyWith({
    List<ExerciseDetails>? exercises,
    String? name,
    bool? reordering,
  }) {
    return WorkoutBuilderState(
      exercises: exercises ?? this.exercises,
      name: name ?? this.name,
      reordering: reordering ?? this.reordering,
    );
  }

  @override
  List<Object> get props => [exercises, reordering];
}

class ExerciseDetails extends Equatable {
  final Exercise exercise;
  late final Map<SET, List<Field>> fields;
  ExerciseDetails(this.exercise, {Map<SET, List<Field>>? fields}) {
    if (fields != null) {
      this.fields = fields;
    } else {
      this.fields = {Regular.first(): exercise.initialFields()};
    }
  }

  @protected
  ExerciseDetails removeSet(SET set) {
    final fieldsClone = Map<SET, List<Field>>.from(fields)..remove(set);
    final newFields = <SET, List<Field>>{};
    for (var i = 0; i < fieldsClone.length; i++) {
      newFields[fieldsClone.entries.elementAt(i).key.copyWith(i + 1)] = fieldsClone.entries.elementAt(i).value;
    }
    return ExerciseDetails(exercise, fields: newFields);
  }

  @protected
  ExerciseDetails addSet() {
    return ExerciseDetails(
      exercise,
      fields: Map.from(fields)..[Regular(fields.keys.last.value + 1)] = exercise.initialFields(),
    );
  }

  @protected
  ExerciseDetails updateField<F extends Field>(SET set, F field) {
    final fieldsClone = List<Field>.from(fields[set]!);
    final i = fieldsClone.indexWhere((f) => f is F);
    fieldsClone[i] = field;
    return ExerciseDetails(exercise, fields: Map<SET, List<Field>>.from(fields)..update(set, (_) => fieldsClone));
  }

  @override
  List<Object?> get props => [exercise, fields];
}
