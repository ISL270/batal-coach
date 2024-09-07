enum UserType {
  // Never change the order.
  // Original order: 1- coach, 2- Trainee
  coach,
  trainee;

  String toJson() => name;
  static UserType fromJson(String json) => values.byName(json);
}

extension UserTypeX on UserType {
  bool get isCoach => this == UserType.coach;
  bool get isTrainee => this == UserType.trainee;
}
