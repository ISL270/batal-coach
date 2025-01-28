part of 'exercise_details_cubit.dart';

class ExerciseDetailsState extends Equatable {
  const ExerciseDetailsState({
    required this.images,
    this.activePage = 0,
    this.timerActive = false,
  });

  final int activePage;
  final List<String> images;
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
      timerActive: timerActive ?? this.timerActive,
    );
  }

  @override
  List<Object?> get props => [activePage, images, timerActive];
}
