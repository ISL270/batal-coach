import 'package:btl/app/core/local_db/i_local_db.dart';
import 'package:btl/app/core/models/cache_model.dart';
import 'package:btl/app/features/authentication/data/models/local/user_isar.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

@Singleton(as: LocalDB)
final class IsarDB implements LocalDB {
  final Isar _isar;
  const IsarDB._(this._isar);

  @FactoryMethod(preResolve: true)
  static Future<IsarDB> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [UserIsarSchema],
      directory: dir.path,
    );
    return IsarDB._(isar);
  }

  @override
  Future<bool> delete<T extends CacheModel>(T object) async {
    return _isar.writeTxn(() => _isar.collection<T>().delete(object.cacheID));
  }

  bool deleteSync<T extends CacheModel>(T object) {
    return _isar.writeTxnSync(() => _isar.collection<T>().deleteSync(object.cacheID));
  }

  @override
  Future<void> deleteAll<T extends CacheModel>() async {
    return _isar.writeTxn(() => _isar.collection<T>().clear());
  }

  void deleteAllSync<T extends CacheModel>() {
    return _isar.writeTxnSync(() => _isar.collection<T>().clearSync());
  }

  @override
  Future<int> save<T extends CacheModel>(T object) async {
    return _isar.writeTxn(() => _isar.collection<T>().put(object));
  }

  int saveSync<T extends CacheModel>(T object) {
    return _isar.writeTxnSync(() => _isar.collection<T>().putSync(object));
  }

  @override
  Future<T?> get<T extends CacheModel>(int id) async {
    return _isar.txn(() => _isar.collection<T>().get(id));
  }

  T? getSync<T extends CacheModel>(int id) {
    return _isar.txnSync(() => _isar.collection<T>().getSync(id));
  }

  @override
  Future<List<T>> getAll<T extends CacheModel>() async {
    return _isar.txn(() => _isar.collection<T>().where().findAll());
  }

  List<T> getAlSyncl<T extends CacheModel>() {
    return _isar.txnSync(() => _isar.collection<T>().where().findAllSync());
  }

  @override
  Future<T?> getFirst<T extends CacheModel>() async {
    return _isar.txn(() => _isar.collection<T>().where().findFirst());
  }

  T? getFirstSync<T extends CacheModel>() {
    return _isar.txnSync(() => _isar.collection<T>().where().findFirstSync());
  }
}
