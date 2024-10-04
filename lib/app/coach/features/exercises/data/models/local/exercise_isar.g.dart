// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseIsarCollection on Isar {
  IsarCollection<ExerciseIsar> get exerciseIsars => this.collection();
}

const ExerciseIsarSchema = CollectionSchema(
  name: r'ExerciseIsar',
  id: -8781596793542487269,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
      enumMap: _ExerciseIsarcategoryEnumValueMap,
    ),
    r'equipment': PropertySchema(
      id: 1,
      name: r'equipment',
      type: IsarType.string,
      enumMap: _ExerciseIsarequipmentEnumValueMap,
    ),
    r'fields': PropertySchema(
      id: 2,
      name: r'fields',
      type: IsarType.stringList,
      enumMap: _ExerciseIsarfieldsEnumValueMap,
    ),
    r'force': PropertySchema(
      id: 3,
      name: r'force',
      type: IsarType.string,
      enumMap: _ExerciseIsarforceEnumValueMap,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'images': PropertySchema(
      id: 5,
      name: r'images',
      type: IsarType.stringList,
    ),
    r'instructions': PropertySchema(
      id: 6,
      name: r'instructions',
      type: IsarType.stringList,
    ),
    r'level': PropertySchema(
      id: 7,
      name: r'level',
      type: IsarType.string,
      enumMap: _ExerciseIsarlevelEnumValueMap,
    ),
    r'mainMuscle': PropertySchema(
      id: 8,
      name: r'mainMuscle',
      type: IsarType.string,
      enumMap: _ExerciseIsarmainMuscleEnumValueMap,
    ),
    r'mechanic': PropertySchema(
      id: 9,
      name: r'mechanic',
      type: IsarType.string,
      enumMap: _ExerciseIsarmechanicEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'secondaryMuscles': PropertySchema(
      id: 11,
      name: r'secondaryMuscles',
      type: IsarType.stringList,
      enumMap: _ExerciseIsarsecondaryMusclesEnumValueMap,
    )
  },
  estimateSize: _exerciseIsarEstimateSize,
  serialize: _exerciseIsarSerialize,
  deserialize: _exerciseIsarDeserialize,
  deserializeProp: _exerciseIsarDeserializeProp,
  idName: r'cacheID',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _exerciseIsarGetId,
  getLinks: _exerciseIsarGetLinks,
  attach: _exerciseIsarAttach,
  version: '3.1.0+1',
);

int _exerciseIsarEstimateSize(
  ExerciseIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.equipment;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.fields.length * 3;
  {
    for (var i = 0; i < object.fields.length; i++) {
      final value = object.fields[i];
      bytesCount += value.name.length * 3;
    }
  }
  {
    final value = object.force;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.images.length * 3;
  {
    for (var i = 0; i < object.images.length; i++) {
      final value = object.images[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.instructions.length * 3;
  {
    for (var i = 0; i < object.instructions.length; i++) {
      final value = object.instructions[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.level;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.mainMuscle.name.length * 3;
  {
    final value = object.mechanic;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.secondaryMuscles.length * 3;
  {
    for (var i = 0; i < object.secondaryMuscles.length; i++) {
      final value = object.secondaryMuscles[i];
      bytesCount += value.name.length * 3;
    }
  }
  return bytesCount;
}

void _exerciseIsarSerialize(
  ExerciseIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category?.name);
  writer.writeString(offsets[1], object.equipment?.name);
  writer.writeStringList(offsets[2], object.fields.map((e) => e.name).toList());
  writer.writeString(offsets[3], object.force?.name);
  writer.writeString(offsets[4], object.id);
  writer.writeStringList(offsets[5], object.images);
  writer.writeStringList(offsets[6], object.instructions);
  writer.writeString(offsets[7], object.level?.name);
  writer.writeString(offsets[8], object.mainMuscle.name);
  writer.writeString(offsets[9], object.mechanic?.name);
  writer.writeString(offsets[10], object.name);
  writer.writeStringList(
      offsets[11], object.secondaryMuscles.map((e) => e.name).toList());
}

ExerciseIsar _exerciseIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseIsar(
    category:
        _ExerciseIsarcategoryValueEnumMap[reader.readStringOrNull(offsets[0])],
    equipment:
        _ExerciseIsarequipmentValueEnumMap[reader.readStringOrNull(offsets[1])],
    fields: reader
            .readStringList(offsets[2])
            ?.map((e) => _ExerciseIsarfieldsValueEnumMap[e] ?? FieldType.time)
            .toList() ??
        [],
    force: _ExerciseIsarforceValueEnumMap[reader.readStringOrNull(offsets[3])],
    id: reader.readString(offsets[4]),
    images: reader.readStringList(offsets[5]) ?? [],
    instructions: reader.readStringList(offsets[6]) ?? [],
    level: _ExerciseIsarlevelValueEnumMap[reader.readStringOrNull(offsets[7])],
    mainMuscle: _ExerciseIsarmainMuscleValueEnumMap[
            reader.readStringOrNull(offsets[8])] ??
        Muscle.quadriceps,
    mechanic:
        _ExerciseIsarmechanicValueEnumMap[reader.readStringOrNull(offsets[9])],
    name: reader.readString(offsets[10]),
    secondaryMuscles: reader
            .readStringList(offsets[11])
            ?.map((e) =>
                _ExerciseIsarsecondaryMusclesValueEnumMap[e] ??
                Muscle.quadriceps)
            .toList() ??
        [],
  );
  return object;
}

P _exerciseIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ExerciseIsarcategoryValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 1:
      return (_ExerciseIsarequipmentValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 2:
      return (reader
              .readStringList(offset)
              ?.map((e) => _ExerciseIsarfieldsValueEnumMap[e] ?? FieldType.time)
              .toList() ??
          []) as P;
    case 3:
      return (_ExerciseIsarforceValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (_ExerciseIsarlevelValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 8:
      return (_ExerciseIsarmainMuscleValueEnumMap[
              reader.readStringOrNull(offset)] ??
          Muscle.quadriceps) as P;
    case 9:
      return (_ExerciseIsarmechanicValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader
              .readStringList(offset)
              ?.map((e) =>
                  _ExerciseIsarsecondaryMusclesValueEnumMap[e] ??
                  Muscle.quadriceps)
              .toList() ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ExerciseIsarcategoryEnumValueMap = {
  r'strength': r'strength',
  r'stretching': r'stretching',
  r'plyometrics': r'plyometrics',
  r'powerLifting': r'powerLifting',
  r'olympicWeightlifting': r'olympicWeightlifting',
  r'strongman': r'strongman',
  r'cardio': r'cardio',
};
const _ExerciseIsarcategoryValueEnumMap = {
  r'strength': ExCategory.strength,
  r'stretching': ExCategory.stretching,
  r'plyometrics': ExCategory.plyometrics,
  r'powerLifting': ExCategory.powerLifting,
  r'olympicWeightlifting': ExCategory.olympicWeightlifting,
  r'strongman': ExCategory.strongman,
  r'cardio': ExCategory.cardio,
};
const _ExerciseIsarequipmentEnumValueMap = {
  r'barbell': r'barbell',
  r'dumbbell': r'dumbbell',
  r'cable': r'cable',
  r'machine': r'machine',
  r'kettlebells': r'kettlebells',
  r'bands': r'bands',
  r'medicineBall': r'medicineBall',
  r'exerciseBall': r'exerciseBall',
  r'foamRoll': r'foamRoll',
  r'ezCurlBar': r'ezCurlBar',
  r'bodyOnly': r'bodyOnly',
  r'other': r'other',
};
const _ExerciseIsarequipmentValueEnumMap = {
  r'barbell': Equipment.barbell,
  r'dumbbell': Equipment.dumbbell,
  r'cable': Equipment.cable,
  r'machine': Equipment.machine,
  r'kettlebells': Equipment.kettlebells,
  r'bands': Equipment.bands,
  r'medicineBall': Equipment.medicineBall,
  r'exerciseBall': Equipment.exerciseBall,
  r'foamRoll': Equipment.foamRoll,
  r'ezCurlBar': Equipment.ezCurlBar,
  r'bodyOnly': Equipment.bodyOnly,
  r'other': Equipment.other,
};
const _ExerciseIsarfieldsEnumValueMap = {
  r'time': r'time',
  r'distance': r'distance',
  r'weight': r'weight',
  r'reps': r'reps',
};
const _ExerciseIsarfieldsValueEnumMap = {
  r'time': FieldType.time,
  r'distance': FieldType.distance,
  r'weight': FieldType.weight,
  r'reps': FieldType.reps,
};
const _ExerciseIsarforceEnumValueMap = {
  r'pull': r'pull',
  r'push': r'push',
  r'static': r'static',
};
const _ExerciseIsarforceValueEnumMap = {
  r'pull': Force.pull,
  r'push': Force.push,
  r'static': Force.static,
};
const _ExerciseIsarlevelEnumValueMap = {
  r'beginner': r'beginner',
  r'intermediate': r'intermediate',
  r'expert': r'expert',
};
const _ExerciseIsarlevelValueEnumMap = {
  r'beginner': ExLevel.beginner,
  r'intermediate': ExLevel.intermediate,
  r'expert': ExLevel.expert,
};
const _ExerciseIsarmainMuscleEnumValueMap = {
  r'quadriceps': r'quadriceps',
  r'shoulders': r'shoulders',
  r'abdominals': r'abdominals',
  r'chest': r'chest',
  r'hamstrings': r'hamstrings',
  r'triceps': r'triceps',
  r'biceps': r'biceps',
  r'lats': r'lats',
  r'middleBack': r'middleBack',
  r'calves': r'calves',
  r'lowerBack': r'lowerBack',
  r'forearms': r'forearms',
  r'glutes': r'glutes',
  r'traps': r'traps',
  r'adductors': r'adductors',
  r'abductors': r'abductors',
  r'neck': r'neck',
};
const _ExerciseIsarmainMuscleValueEnumMap = {
  r'quadriceps': Muscle.quadriceps,
  r'shoulders': Muscle.shoulders,
  r'abdominals': Muscle.abdominals,
  r'chest': Muscle.chest,
  r'hamstrings': Muscle.hamstrings,
  r'triceps': Muscle.triceps,
  r'biceps': Muscle.biceps,
  r'lats': Muscle.lats,
  r'middleBack': Muscle.middleBack,
  r'calves': Muscle.calves,
  r'lowerBack': Muscle.lowerBack,
  r'forearms': Muscle.forearms,
  r'glutes': Muscle.glutes,
  r'traps': Muscle.traps,
  r'adductors': Muscle.adductors,
  r'abductors': Muscle.abductors,
  r'neck': Muscle.neck,
};
const _ExerciseIsarmechanicEnumValueMap = {
  r'compound': r'compound',
  r'isolation': r'isolation',
};
const _ExerciseIsarmechanicValueEnumMap = {
  r'compound': Mechanic.compound,
  r'isolation': Mechanic.isolation,
};
const _ExerciseIsarsecondaryMusclesEnumValueMap = {
  r'quadriceps': r'quadriceps',
  r'shoulders': r'shoulders',
  r'abdominals': r'abdominals',
  r'chest': r'chest',
  r'hamstrings': r'hamstrings',
  r'triceps': r'triceps',
  r'biceps': r'biceps',
  r'lats': r'lats',
  r'middleBack': r'middleBack',
  r'calves': r'calves',
  r'lowerBack': r'lowerBack',
  r'forearms': r'forearms',
  r'glutes': r'glutes',
  r'traps': r'traps',
  r'adductors': r'adductors',
  r'abductors': r'abductors',
  r'neck': r'neck',
};
const _ExerciseIsarsecondaryMusclesValueEnumMap = {
  r'quadriceps': Muscle.quadriceps,
  r'shoulders': Muscle.shoulders,
  r'abdominals': Muscle.abdominals,
  r'chest': Muscle.chest,
  r'hamstrings': Muscle.hamstrings,
  r'triceps': Muscle.triceps,
  r'biceps': Muscle.biceps,
  r'lats': Muscle.lats,
  r'middleBack': Muscle.middleBack,
  r'calves': Muscle.calves,
  r'lowerBack': Muscle.lowerBack,
  r'forearms': Muscle.forearms,
  r'glutes': Muscle.glutes,
  r'traps': Muscle.traps,
  r'adductors': Muscle.adductors,
  r'abductors': Muscle.abductors,
  r'neck': Muscle.neck,
};

Id _exerciseIsarGetId(ExerciseIsar object) {
  return object.cacheID;
}

List<IsarLinkBase<dynamic>> _exerciseIsarGetLinks(ExerciseIsar object) {
  return [];
}

void _exerciseIsarAttach(
    IsarCollection<dynamic> col, Id id, ExerciseIsar object) {}

extension ExerciseIsarQueryWhereSort
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QWhere> {
  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhere> anyCacheID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension ExerciseIsarQueryWhere
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QWhereClause> {
  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> cacheIDEqualTo(
      Id cacheID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: cacheID,
        upper: cacheID,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> cacheIDNotEqualTo(
      Id cacheID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: cacheID, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: cacheID, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: cacheID, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: cacheID, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause>
      cacheIDGreaterThan(Id cacheID, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: cacheID, includeLower: include),
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> cacheIDLessThan(
      Id cacheID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: cacheID, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> cacheIDBetween(
    Id lowerCacheID,
    Id upperCacheID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerCacheID,
        includeLower: includeLower,
        upper: upperCacheID,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }
}

extension ExerciseIsarQueryFilter
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QFilterCondition> {
  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      cacheIDEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheID',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      cacheIDGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cacheID',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      cacheIDLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cacheID',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      cacheIDBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cacheID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryEqualTo(
    ExCategory? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryGreaterThan(
    ExCategory? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryLessThan(
    ExCategory? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryBetween(
    ExCategory? lower,
    ExCategory? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'equipment',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'equipment',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentEqualTo(
    Equipment? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentGreaterThan(
    Equipment? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentLessThan(
    Equipment? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentBetween(
    Equipment? lower,
    Equipment? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'equipment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'equipment',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equipment',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      equipmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'equipment',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementEqualTo(
    FieldType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementGreaterThan(
    FieldType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementLessThan(
    FieldType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementBetween(
    FieldType lower,
    FieldType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fields',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fields',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fields',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fields',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fields',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fields',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fields',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fields',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fields',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      fieldsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fields',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      forceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'force',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      forceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'force',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> forceEqualTo(
    Force? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'force',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      forceGreaterThan(
    Force? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'force',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> forceLessThan(
    Force? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'force',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> forceBetween(
    Force? lower,
    Force? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'force',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      forceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'force',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> forceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'force',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> forceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'force',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> forceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'force',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      forceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'force',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      forceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'force',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'images',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'images',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'images',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'images',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'images',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'images',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'images',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'images',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'images',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'images',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      imagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instructions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'instructions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructions',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'instructions',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      instructionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      levelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'level',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      levelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'level',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> levelEqualTo(
    ExLevel? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      levelGreaterThan(
    ExLevel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'level',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> levelLessThan(
    ExLevel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'level',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> levelBetween(
    ExLevel? lower,
    ExLevel? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'level',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      levelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'level',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> levelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'level',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> levelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'level',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> levelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'level',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      levelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      levelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'level',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleEqualTo(
    Muscle value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainMuscle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleGreaterThan(
    Muscle value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainMuscle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleLessThan(
    Muscle value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainMuscle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleBetween(
    Muscle lower,
    Muscle upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainMuscle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainMuscle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainMuscle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainMuscle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainMuscle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainMuscle',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mainMuscleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainMuscle',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mechanic',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mechanic',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicEqualTo(
    Mechanic? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mechanic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicGreaterThan(
    Mechanic? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mechanic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicLessThan(
    Mechanic? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mechanic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicBetween(
    Mechanic? lower,
    Mechanic? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mechanic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mechanic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mechanic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mechanic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mechanic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mechanic',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      mechanicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mechanic',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementEqualTo(
    Muscle value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryMuscles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementGreaterThan(
    Muscle value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondaryMuscles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementLessThan(
    Muscle value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondaryMuscles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementBetween(
    Muscle lower,
    Muscle upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondaryMuscles',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondaryMuscles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondaryMuscles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondaryMuscles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondaryMuscles',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryMuscles',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondaryMuscles',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscles',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscles',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscles',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscles',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscles',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterFilterCondition>
      secondaryMusclesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secondaryMuscles',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ExerciseIsarQueryObject
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QFilterCondition> {}

extension ExerciseIsarQueryLinks
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QFilterCondition> {}

extension ExerciseIsarQuerySortBy
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QSortBy> {
  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByEquipmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByForce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'force', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByForceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'force', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByMainMuscle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainMuscle', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy>
      sortByMainMuscleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainMuscle', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByMechanic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mechanic', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByMechanicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mechanic', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ExerciseIsarQuerySortThenBy
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QSortThenBy> {
  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByCacheID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheID', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByCacheIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheID', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByEquipmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByForce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'force', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByForceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'force', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByMainMuscle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainMuscle', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy>
      thenByMainMuscleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainMuscle', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByMechanic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mechanic', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByMechanicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mechanic', Sort.desc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ExerciseIsarQueryWhereDistinct
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> {
  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByEquipment(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equipment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByFields() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fields');
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByForce(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'force', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'images');
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructions');
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByMainMuscle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainMuscle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByMechanic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mechanic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseIsar, ExerciseIsar, QDistinct>
      distinctBySecondaryMuscles() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryMuscles');
    });
  }
}

extension ExerciseIsarQueryProperty
    on QueryBuilder<ExerciseIsar, ExerciseIsar, QQueryProperty> {
  QueryBuilder<ExerciseIsar, int, QQueryOperations> cacheIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheID');
    });
  }

  QueryBuilder<ExerciseIsar, ExCategory?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<ExerciseIsar, Equipment?, QQueryOperations> equipmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equipment');
    });
  }

  QueryBuilder<ExerciseIsar, List<FieldType>, QQueryOperations>
      fieldsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fields');
    });
  }

  QueryBuilder<ExerciseIsar, Force?, QQueryOperations> forceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'force');
    });
  }

  QueryBuilder<ExerciseIsar, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExerciseIsar, List<String>, QQueryOperations> imagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'images');
    });
  }

  QueryBuilder<ExerciseIsar, List<String>, QQueryOperations>
      instructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructions');
    });
  }

  QueryBuilder<ExerciseIsar, ExLevel?, QQueryOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<ExerciseIsar, Muscle, QQueryOperations> mainMuscleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainMuscle');
    });
  }

  QueryBuilder<ExerciseIsar, Mechanic?, QQueryOperations> mechanicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mechanic');
    });
  }

  QueryBuilder<ExerciseIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ExerciseIsar, List<Muscle>, QQueryOperations>
      secondaryMusclesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryMuscles');
    });
  }
}
