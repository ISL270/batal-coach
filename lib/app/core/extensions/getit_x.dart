import 'package:btl/app/core/l10n/l10n_service.dart';
import 'package:btl/app/core/services/local_db/isar_db.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  // Blocs
  AuthBloc get authBloc => get<AuthBloc>();

  // Services
  IsarDB get localDB => get<IsarDB>();
  L10nService get l10nSvc => get<L10nService>();

  // Repositories
  AuthRepository get authRepo => get<AuthRepository>();
}
