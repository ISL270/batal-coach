enum CoachType { fitnessCoach, nutritionCoach, manager }

extension CoachTypeX on CoachType {
  bool get isFitnessCoach => this == CoachType.fitnessCoach;
  bool get isNutritionCoach => this == CoachType.nutritionCoach;
  bool get isManager => this == CoachType.manager;
}
