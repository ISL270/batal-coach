part of 'exercise_details_cubit.dart';

class ExerciseDetailsState extends Equatable {
  const ExerciseDetailsState({
    required this.images,
    required this.setupLines,
    this.activePage = 0,
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
