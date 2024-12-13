enum CoachType {
  //1. fitness coach
  //2. nutrition coach
  //3. manager

  fitness,
  nutrition,
  manager;

  String toStringValue() {
    switch (this) {
      case CoachType.fitness:
        return 'fitness';
      case CoachType.nutrition:
        return 'nutrition';
      case CoachType.manager:
        return 'manager';
    }
  }
}

extension CoachTypeX on CoachType {
  bool get isFitness => this == CoachType.fitness;
  bool get isNutrition => this == CoachType.nutrition;
  bool get isManager => this == CoachType.manager;
}
