enum Status {
  initial,
  success,
  failure,
  loading,
  pageLoading;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
  bool get isPageLoading => this == pageLoading;
}
