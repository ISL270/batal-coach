final class Client {
  final String? coachEmail;
  final String clientEmail;
  final String name;
  final String phone;
  final String id;
  final String userType;

  Client({
    required this.clientEmail,
    required this.name,
    required this.phone,
    required this.id,
    required this.userType,
    this.coachEmail,
  });
}
