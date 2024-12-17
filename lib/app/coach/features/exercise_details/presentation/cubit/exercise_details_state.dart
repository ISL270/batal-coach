part of 'exercise_details_cubit.dart';

class ExerciseDetailsState extends Equatable {
  const ExerciseDetailsState({
    this.activePage = 0,
    this.images = const [
      'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2FDead-Bug.gif?alt=media&token=fd845f6f-9f96-4f8d-a904-b3ee8519d56c',
      'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2FOblique-Floor-Crunches.gif?alt=media&token=e137c34c-6aa4-4f72-a17f-eba678134b0b',
      'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2Fweighted_crunches.gif?alt=media&token=b17224d9-6542-4292-b600-fd9949a7f913',
    ],
    this.setupLines = const [
      'Lie down on your back.',
      'Bend your legs and stabilize your lower body.',
      'Cross your hands to opposite shoulders, or place them behind your ears without pulling on your neck.',
      'Lift your head and shoulder blades from the ground. Exhale as you rise.',
      'Lower, returning to your starting point. Inhale as you lower.',
    ],
    this.timerActive = false,
  });

  final int activePage;
  final List<String> images;
  final List<String> setupLines;
  final bool timerActive;

  ExerciseDetailsState copyWith({
    int? activePage,
    List<String>? images,
    List<String>? setupLines,
    bool? timerActive,
  }) {
    return ExerciseDetailsState(
      activePage: activePage ?? this.activePage,
      images: images ?? this.images,
      setupLines: setupLines ?? this.setupLines,
      timerActive: timerActive ?? this.timerActive,
    );
  }

  @override
  List<Object?> get props => [activePage, images, setupLines, timerActive];
}
