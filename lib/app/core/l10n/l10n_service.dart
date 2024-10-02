import 'package:btl/app/coach/features/exercises/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercises/domain/models/muscle.dart';
import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
final class L10nService {
  AppLocalizations l10n(BuildContext context) => AppLocalizations.of(context);

  String trFromStr(String trStrKey, BuildContext context) {
    final trKey = _Transaltions.values.firstOrNullWhere((tr) => tr.name == trStrKey);
    if (trKey == null) return trStrKey;
    return trKey.getTr(context.settingsBloc.state.language);
  }

  String trFromEnum<T extends Enum>(T enumKey, BuildContext context) {
    final trKey = _Transaltions.getFromEnum(enumKey);
    if (trKey == null) return enumKey.name;
    return trKey.getTr(context.settingsBloc.state.language);
  }
}

/// Translations that can't be predefined in [AppLocalizations]
enum _Transaltions {
  nameRequired(ar: 'الاسم مطلوب', en: 'Name is required'),
  strength(ar: 'القوة', en: 'Strength'),
  stretching(ar: 'تمارين الإطالة', en: 'Stretching'),
  plyometrics(ar: 'تمارين البلومتريكس', en: 'Plyometrics'),
  powerLifting(ar: 'رفع الأثقال', en: 'Powerlifting'),
  olympicWeightlifting(ar: 'رفع الأثقال الأولمبي', en: 'Olympic Weightlifting'),
  strongman(ar: 'القوة البدنية', en: 'Strongman'),
  cardio(ar: 'تمارين الكارديو', en: 'Cardio'),
  quadriceps(ar: 'عضلة الفخذ الرباعية', en: 'Quadriceps'),
  shoulders(ar: 'الكتفين', en: 'Shoulders'),
  abdominals(ar: 'عضلات البطن', en: 'Abdominals'),
  chest(ar: 'الصدر', en: 'Chest'),
  hamstrings(ar: 'أوتار الركبة', en: 'Hamstrings'),
  triceps(ar: 'العضلة ثلاثية الرؤوس', en: 'Triceps'),
  biceps(ar: 'العضلة ذات الرأسين', en: 'Biceps'),
  lats(ar: 'عضلات الظهر الجانبية', en: 'Lats'),
  middleBack(ar: 'منتصف الظهر', en: 'Middle Back'),
  calves(ar: 'عضلات الساق', en: 'Calves'),
  lowerBack(ar: 'أسفل الظهر', en: 'Lower Back'),
  forearms(ar: 'الساعدين', en: 'Forearms'),
  glutes(ar: 'عضلات الأرداف', en: 'Glutes'),
  traps(ar: 'عضلات شبه المنحرفة', en: 'Traps'),
  adductors(ar: 'العضلات الضامة', en: 'Adductors'),
  abductors(ar: 'العضلات المبعدة', en: 'Abductors'),
  neck(ar: 'الرقبة', en: 'Neck'),
  beginner(ar: 'مبتدئ', en: 'Beginner'),
  intermediate(ar: 'متوسط', en: 'Intermediate'),
  expert(ar: 'خبير', en: 'Expert'),
  barbell(ar: 'باربيل', en: 'Barbell'),
  dumbbell(ar: 'دمبل', en: 'Dumbbell'),
  cable(ar: 'كابل', en: 'Cable'),
  machine(ar: 'آلة', en: 'Machine'),
  kettlebells(ar: 'الدامبل الروسي', en: 'Kettlebells'),
  bands(ar: 'أشرطة المقاومة', en: 'Bands'),
  medicineBall(ar: 'كرة طبية', en: 'Medicine Ball'),
  exerciseBall(ar: 'كرة التمارين', en: 'Exercise Ball'),
  foamRoll(ar: 'أسطوانة الفوم', en: 'Foam Roll'),
  ezCurlBar(ar: 'بار الزد كيرل', en: 'EZ Curl Bar'),
  bodyOnly(ar: 'تمارين بوزن الجسم فقط', en: 'Body Only'),
  other(ar: 'أخرى', en: 'Other');

  static _Transaltions? getFromEnum<T extends Enum>(T enumVal) {
    if (enumVal is ExCategory) {
      switch (enumVal) {
        case ExCategory.strength:
          return _Transaltions.strength;
        case ExCategory.stretching:
          return _Transaltions.stretching;
        case ExCategory.plyometrics:
          return _Transaltions.plyometrics;
        case ExCategory.powerLifting:
          return _Transaltions.powerLifting;
        case ExCategory.olympicWeightlifting:
          return _Transaltions.olympicWeightlifting;
        case ExCategory.strongman:
          return _Transaltions.strongman;
        case ExCategory.cardio:
          return _Transaltions.cardio;
      }
    }

    if (enumVal is Muscle) {
      switch (enumVal) {
        case Muscle.quadriceps:
          return _Transaltions.quadriceps;
        case Muscle.shoulders:
          return _Transaltions.shoulders;
        case Muscle.abdominals:
          return _Transaltions.abdominals;
        case Muscle.chest:
          return _Transaltions.chest;
        case Muscle.hamstrings:
          return _Transaltions.hamstrings;
        case Muscle.triceps:
          return _Transaltions.triceps;
        case Muscle.biceps:
          return _Transaltions.biceps;
        case Muscle.lats:
          return _Transaltions.lats;
        case Muscle.middleBack:
          return _Transaltions.middleBack;
        case Muscle.calves:
          return _Transaltions.calves;
        case Muscle.lowerBack:
          return _Transaltions.lowerBack;
        case Muscle.forearms:
          return _Transaltions.forearms;
        case Muscle.glutes:
          return _Transaltions.glutes;
        case Muscle.traps:
          return _Transaltions.traps;
        case Muscle.adductors:
          return _Transaltions.adductors;
        case Muscle.abductors:
          return _Transaltions.abductors;
        case Muscle.neck:
          return _Transaltions.neck;
      }
    }
    if (enumVal is ExLevel) {
      switch (enumVal) {
        case ExLevel.beginner:
          return _Transaltions.beginner;
        case ExLevel.intermediate:
          return _Transaltions.intermediate;
        case ExLevel.expert:
          return _Transaltions.expert;
      }
    }
    if (enumVal is Equipment) {
      switch (enumVal) {
        case Equipment.barbell:
          return _Transaltions.barbell;
        case Equipment.dumbbell:
          return _Transaltions.dumbbell;
        case Equipment.cable:
          return _Transaltions.cable;
        case Equipment.machine:
          return _Transaltions.machine;
        case Equipment.kettlebells:
          return _Transaltions.kettlebells;
        case Equipment.bands:
          return _Transaltions.bands;
        case Equipment.medicineBall:
          return _Transaltions.medicineBall;
        case Equipment.exerciseBall:
          return _Transaltions.exerciseBall;
        case Equipment.foamRoll:
          return _Transaltions.foamRoll;
        case Equipment.ezCurlBar:
          return _Transaltions.ezCurlBar;
        case Equipment.bodyOnly:
          return _Transaltions.bodyOnly;
        case Equipment.other:
          return _Transaltions.other;
      }
    }
    return null;
  }

  final String ar;
  final String en;

  const _Transaltions({
    required this.ar,
    required this.en,
  });

  String getTr(Language lang) => switch (lang) {
        Language.arabic => ar,
        Language.english => en,
      };
}
