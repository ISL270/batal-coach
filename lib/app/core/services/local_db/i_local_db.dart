// ignore_for_file: strict_raw_type

import 'package:btl/app/core/models/cache_model.dart';

abstract interface class LocalDB {
  Future<T?> getFirst<T extends CacheModel>();
  Future<T?> get<T extends CacheModel>(int id);
  Future<List<T>> getAll<T extends CacheModel>();
  Future<int> put<T extends CacheModel>(T object);
  Future<List<int>> putAll<T extends CacheModel>(List<T> object);
  Future<bool> delete<T extends CacheModel>(T object);
  Future<int> deleteAll<T extends CacheModel>(List<int> ids);
  Future<void> clear<T extends CacheModel>();
}
