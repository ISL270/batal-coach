abstract interface class ReactiveRepository<T> {
  Stream<T> getUpdates();
}
