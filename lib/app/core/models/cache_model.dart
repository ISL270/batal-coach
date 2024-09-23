import 'package:isar/isar.dart';

abstract class CacheModel<D> {
  Id get cacheID;
  const CacheModel();

  D toDomain();
}
