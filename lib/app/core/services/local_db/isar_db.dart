// ignore_for_file: strict_raw_type

import 'package:btl/app/coach/features/exercises/data/models/local/exercise_isar.dart';
import 'package:btl/app/core/extensions/string_x.dart';
import 'package:btl/app/core/models/cache_model.dart';
import 'package:btl/app/core/services/local_db/i_local_db.dart';
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
      [
        UserIsarSchema,
        ExerciseIsarSchema,
      ],
      directory: dir.path,
    );
    return IsarDB._(isar);
  }

  // Usefull to access it for custom queries.
  Isar get isar => _isar;

  @override
  Future<int> put<T extends CacheModel>(T object) async {
    return _isar.writeTxn(() => _isar.collection<T>().put(object));
  }

  int putSync<T extends CacheModel>(T object) {
    return _isar.writeTxnSync(() => _isar.collection<T>().putSync(object));
  }

  @override
  Future<List<int>> putAll<T extends CacheModel>(List<T> objects) async {
    return _isar.writeTxn(() => _isar.collection<T>().putAll(objects));
  }

  @override
  Future<T?> get<T extends CacheModel>(String id) async {
    return _isar.txn(() => _isar.collection<T>().get(id.fastHash));
  }

  T? getSync<T extends CacheModel>(int id) {
    return _isar.txnSync(() => _isar.collection<T>().getSync(id));
  }

  @override
  Future<T?> getFirst<T extends CacheModel>() async {
    return _isar.txn(() => _isar.collection<T>().where().findFirst());
  }

  T? getFirstSync<T extends CacheModel>() {
    return _isar.txnSync(() => _isar.collection<T>().where().findFirstSync());
  }

  @override
  Future<List<T>> getAll<T extends CacheModel>() async {
    return _isar.txn(() => _isar.collection<T>().where().findAll());
  }

  List<T> getAlSync<T extends CacheModel>() {
    return _isar.txnSync(() => _isar.collection<T>().where().findAllSync());
  }

  @override
  Future<bool> delete<T extends CacheModel>(T object) async {
    return _isar.writeTxn(() => _isar.collection<T>().delete(object.cacheID));
  }

  bool deleteSync<T extends CacheModel>(T object) {
    return _isar.writeTxnSync(() => _isar.collection<T>().deleteSync(object.cacheID));
  }

  @override
  Future<int> deleteAll<T extends CacheModel>(List<String> ids) async {
    return _isar
        .writeTxn(() => _isar.collection<T>().deleteAll(ids.map((e) => e.fastHash).toList()));
  }

  Future<int> deleteAllSync<T extends CacheModel>(List<int> ids) async {
    return _isar.writeTxnSync(() => _isar.collection<T>().deleteAllSync(ids));
  }

  @override
  Future<void> clear<T extends CacheModel>() async {
    return _isar.writeTxn(() => _isar.collection<T>().clear());
  }

  void clearSync<T extends CacheModel>() {
    return _isar.writeTxnSync(() => _isar.collection<T>().clearSync());
  }

  @override
  Future<List<T>> getAllByIDs<T extends CacheModel>(List<String> ids) async {
    return _isar.txn(() async {
      final docs = await _isar.collection<T>().getAll(ids.map((e) => e.fastHash).toList());
      // Remove nulls.
      return docs.whereType<T>().toList();
    });
  }

  List<T> getAllByIDsSync<T extends CacheModel>(List<String> ids) {
    return _isar.txnSync(() {
      final docs = _isar.collection<T>().getAllSync(ids.map((e) => e.fastHash).toList());
      // Remove nulls.
      return docs.whereType<T>().toList();
    });
  }
}
