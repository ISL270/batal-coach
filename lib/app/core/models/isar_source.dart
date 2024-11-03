import 'package:btl/app/core/models/cache_model.dart';
import 'package:btl/app/core/services/local_db/isar_db.dart';
import 'package:flutter/foundation.dart';

abstract base class IsarSource<D, C extends CacheModel<D>> {
  @protected
  final IsarDB localDB;

  const IsarSource(this.localDB);

  Future<void> clear() => localDB.clear<C>();

  Future<List<int>> putAll(List<D> list) => localDB.putAll<C>(list.map(fromDomain).toList());

  C fromDomain(D dm);
}
