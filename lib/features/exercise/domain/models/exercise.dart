class Exercise {
  final String id;
  final String name;
  final String? force;
  final String? level;
  final String? mechanic;
  final String? category;
  final String? equipment;
  final String? instructions;
  final Set<String> images;
  final Set<String> primaryMuscles;
  final Set<String> secondaryMuscles;

  Exercise({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.mechanic,
    required this.category,
    required this.equipment,
    required this.instructions,
    required this.images,
    required this.primaryMuscles,
    required this.secondaryMuscles,
  });
}
