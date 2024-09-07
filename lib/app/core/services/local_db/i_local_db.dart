import 'package:btl/app/core/models/cache_model.dart';

abstract interface class LocalDB {
  Future<T?> getFirst<T extends CacheModel>();
  Future<T?> get<T extends CacheModel>(int id);
  Future<List<T>> getAll<T extends CacheModel>();
  Future<int> save<T extends CacheModel>(T object);
  Future<bool> delete<T extends CacheModel>(T object);
  Future<void> deleteAll<T extends CacheModel>();
}
