import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'exercise_details_state.dart';

class ExerciseDetailsCubit extends Cubit<ExerciseDetailsState> {
  ExerciseDetailsCubit() : super(const ExerciseDetailsState());

  final PageController pageController = PageController();
  Timer? timer;

  // start timer and start delay between image with the next one ( 3 seconds )
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!pageController.hasClients) return;
      final currentPage = pageController.page?.round() ?? 0;
      if (currentPage == state.images.length - 1) {
        pageController.animateToPage(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.decelerate,
        );
      } else {
        pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.decelerate);
      }
    });
    emit(state.copyWith(timerActive: true)); // update timerActive value that is initially false
  }

  void cancelTimer() {
    timer?.cancel();
    emit(state.copyWith(timerActive: false)); // used to cancel timer
  }

  // change active page when clicking on the bottom dots
  void changeActivePage(int index) {
    emit(state.copyWith(activePage: index)); // update activePage ( display image )
  }

  @override
  Future<void> close() {
    cancelTimer();
    pageController.dispose();
    return super.close();
  }
}
