enum CoachType { fitnessCoach, nutritionCoach, manager }

extension CoachTypeX on CoachType {
  bool get isFitness => this == CoachType.fitnessCoach;
  bool get isNutrition => this == CoachType.nutritionCoach;
  bool get isManager => this == CoachType.manager;
}
