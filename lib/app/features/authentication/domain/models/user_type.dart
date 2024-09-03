enum UserType {
  coach,
  trainee;

  String toJson() => name;
  static UserType fromJson(String json) => values.byName(json);
}

extension UserTypeX on UserType {
  bool get isCoach => this == UserType.coach;
  bool get isTrainee => this == UserType.trainee;
}
