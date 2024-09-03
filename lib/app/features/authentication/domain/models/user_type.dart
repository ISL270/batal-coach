enum UserType {
  coach,
  trainee;

  String toJson() => name;
  static UserType fromJson(String json) => values.byName(json);
}
