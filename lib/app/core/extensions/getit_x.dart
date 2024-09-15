import 'package:btl/app/coach/features/clients/presentation/bloc/clients_bloc.dart';
import 'package:btl/app/coach/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/app/core/l10n/l10n_service.dart';
import 'package:btl/app/core/services/local_db/i_local_db.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  // Blocs
  AuthBloc get authBloc => get<AuthBloc>();
  ClientsBloc get clientsBloc => get<ClientsBloc>();
  ExerciseBloc get exerciseBloc => get<ExerciseBloc>();

  // Services
  LocalDB get localDB => get<LocalDB>();
  L10nService get l10nSvc => get<L10nService>();

  // Repositories
  AuthRepository get authRepo => get<AuthRepository>();
}
