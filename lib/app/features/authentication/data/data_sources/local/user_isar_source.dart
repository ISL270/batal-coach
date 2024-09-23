import 'package:btl/app/core/services/local_db/i_local_db.dart';
import 'package:btl/app/features/authentication/data/data_sources/local/user_local_source.dart';
import 'package:btl/app/features/authentication/data/models/local/user_isar.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserLocalSource)
final class UserIsarSource implements UserLocalSource {
  @override
  final LocalDB localDB;

  const UserIsarSource(this.localDB);

  @override
  Future<UserIsar?> getSavedUser() => localDB.getFirst<UserIsar>();

  @override
  Future<void> saveUser(User user) => localDB.put(UserIsar.fromDomain(user));

  @override
  Future<void> deleteSavedUser() => localDB.clear<UserIsar>();
}
