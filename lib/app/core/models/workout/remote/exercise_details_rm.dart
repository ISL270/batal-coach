import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/workout/domain/exercise_details.dart';

final class ExerciseDetailsRM {
  final String excID;
  final Map<SET, List<Field>> fields;

  ExerciseDetailsRM(this.excID, this.fields);

  factory ExerciseDetailsRM.fromDomain(ExerciseDetails details) =>
      ExerciseDetailsRM(details.exercise.id, details.fields);

  Map<String, dynamic> toJson() => {
        _idKey: excID,
        _fieldsKey: fields.map((key, value) => MapEntry(
              key.toJson(),
              value.map((e) => e.toJson()).toList(),
            ))
      };

  factory ExerciseDetailsRM.fromJson(Map<String, dynamic> json) => ExerciseDetailsRM(
      json[_idKey] as String,
      (json[_fieldsKey] as Map<dynamic, dynamic>).map(
        (k, e) => MapEntry(SET.fromJson(k as Map<String, dynamic>),
            (e as List<dynamic>).map((e) => Field.fromJson(e as Map<String, dynamic>)).toList()),
      ));

  static const _idKey = 'id';
  static const _fieldsKey = 'fields';
}
