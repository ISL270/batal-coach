import 'package:btl/app/core/models/isar_source.dart';
import 'package:btl/app/features/authentication/data/models/local/user_isar.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserIsarSource extends IsarSource<User, UserIsar> {
  const UserIsarSource(super.localDB);

  Future<UserIsar?> getSavedUser() => localDB.getFirst<UserIsar>();

  Future<void> saveUser(User user) => localDB.put(UserIsar.fromDomain(user));

  Future<void> deleteSavedUser() => localDB.clear<UserIsar>();

  @override
  UserIsar fromDomain(User dm) => UserIsar.fromDomain(dm);
}
