import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List<String> selectedFilters;

  const FilterState({this.selectedFilters = const []});

  @override
  List<Object> get props => [selectedFilters];
}

abstract class FilterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleFilter extends FilterEvent {
  final String filter;

  ToggleFilter(this.filter);

  @override
  List<Object> get props => [filter];
}

class ClearFilters extends FilterEvent {}

class SearchFilters extends FilterEvent {}

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<ToggleFilter>((event, emit) {
      final currentFilters = List<String>.from(state.selectedFilters);
      if (currentFilters.contains(event.filter)) {
        currentFilters.remove(event.filter);
      } else {
        currentFilters.add(event.filter);
      }
      emit(FilterState(selectedFilters: currentFilters));
    });

    on<ClearFilters>((event, emit) {
      emit(const FilterState());
    });

    // Handle search action
    on<SearchFilters>((event, emit) {
      // Perform any search logic here if needed
    });
  }
}
