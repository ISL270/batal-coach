final class Client {
  final String id;

  final String name;

  final String email;

  final String phoneNumber;

  final DateTime lastActiveDate;
  final String? lastActiveString;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.lastActiveDate,
    this.lastActiveString,
  });
}
