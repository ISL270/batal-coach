import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'clients_event.dart';
part 'clients_state.dart';

@injectable
class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final ClientsRepository _repository;

  ClientsBloc(this._repository) : super(ClientsState.initial()) {
    on<_ClientsSubscriptionRequested>(_onSubscriptionRequested);
    add(_ClientsSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _ClientsSubscriptionRequested event,
    Emitter<ClientsState> emit,
  ) async {
    await emit.forEach(
      _repository.getUpdates(),
      onData: (status) => switch (status) {
        Success<List<Client>>(newData: final result) => state.success(result),
        Failure<List<Client>>(:final exception) => state.failure(exception),
        _ => state,
      },
    );
  }

  @override
  Future<void> close() {
    _repository.dispose();
    return super.close();
  }
}
