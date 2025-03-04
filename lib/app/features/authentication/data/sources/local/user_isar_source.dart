import 'package:btl/app/core/isar/isar_source.dart';
import 'package:btl/app/features/authentication/data/models/local/user_isar.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserIsarSource extends IsarSource<User, UserIsar> {
  const UserIsarSource(super.isarService);

  @override
  UserIsar fromDomain(User dm) => UserIsar.fromDomain(dm);
}
