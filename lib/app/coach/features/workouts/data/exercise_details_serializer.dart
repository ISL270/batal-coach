import 'dart:convert';

import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';

mixin ExerciseSetsSerializer {
  Map<String, dynamic> toMap(String excID, Map<SET, List<Field>> fields) => {
        _excIDKey: excID,
        _fieldsKey: fields.map((key, value) => MapEntry(
              jsonEncode(key),
              value.map(jsonEncode).toList(),
            ))
      };

  static (String, Map<SET, List<Field>>) fromMap(Map<String, dynamic> json) {
    final fields = <SET, List<Field>>{};

    // Iterate through the fields map
    (json[_fieldsKey] as Map<String, dynamic>).forEach((key, value) {
      // Decode the key (JSON string) into a SET object
      final setKey = SET.fromJson(jsonDecode(key) as Map<String, dynamic>);

      // Decode the list of JSON strings into a List<Field>
      final fieldList = (value as List<dynamic>)
          .map((item) => Field.fromJson(jsonDecode(item as String) as Map<String, dynamic>))
          .toList();

      // Add the decoded key-value pair to the fields map
      fields[setKey] = fieldList;
    });

    return (
      json[_excIDKey] as String,
      fields,
    );
  }

  static const _excIDKey = 'excID';
  static const _fieldsKey = 'fields';
}
