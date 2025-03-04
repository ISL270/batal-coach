import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'exercise_details_state.dart';

class ExerciseDetailsCubit extends Cubit<ExerciseDetailsState> {
  ExerciseDetailsCubit(List<String> images)
      : super(ExerciseDetailsState(
          images: images,
        )) {
    _startTimer();
  }

  final PageController pageController = PageController();
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!pageController.hasClients) return;
      final currentPage = pageController.page?.round() ?? 0;
      if (currentPage == state.images.length - 1) {
        pageController.animateToPage(
          0,
          duration: const Duration(seconds: 2),
          curve: Curves.decelerate,
        );
      } else {
        pageController.nextPage(duration: const Duration(seconds: 2), curve: Curves.decelerate);
      }
    });
    emit(state.copyWith(timerActive: true));
  }

  void cancelTimer() {
    _timer?.cancel();
    emit(state.copyWith(timerActive: false));
  }

  void changeActivePage(int index) {
    emit(state.copyWith(activePage: index));
  }

  @override
  Future<void> close() {
    cancelTimer();
    pageController.dispose();
    return super.close();
  }
}
