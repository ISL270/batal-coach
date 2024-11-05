import 'package:btl/app/core/models/isar_source.dart';
import 'package:btl/app/features/authentication/data/models/local/user_isar.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserIsarSource extends IsarSource<User, UserIsar> {
  const UserIsarSource(super.isarService);

  Future<UserIsar?> getSavedUser() => isarService.getFirst<UserIsar>();

  Future<void> saveUser(User user) => isarService.put(UserIsar.fromDomain(user));

  Future<void> deleteSavedUser() => isarService.clear<UserIsar>();

  @override
  UserIsar fromDomain(User dm) => UserIsar.fromDomain(dm);
}
