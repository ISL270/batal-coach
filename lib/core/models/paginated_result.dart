class PaginatedResult<T> {
  final List<T> result;
  final int page;
  final bool hasReachedMax;

  const PaginatedResult({
    this.result = const [],
    this.page = 0,
    this.hasReachedMax = false,
  });

  PaginatedResult<T> copyWith({
    List<T>? result,
    int? page,
    bool? hasReachedMax,
  }) {
    return PaginatedResult<T>(
      result: result ?? this.result,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  PaginatedResult<T> appendResult(Iterable<T> result, {required bool hasReachedMax}) => copyWith(
        page: page + 1,
        result: this.result..addAll(result),
        hasReachedMax: hasReachedMax,
      );
}
