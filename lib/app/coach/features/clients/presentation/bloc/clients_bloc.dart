import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/%20clients_repository.dart';
import 'package:btl/app/core/models/generic_exception.dart';
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
      onData: (clients) => state.success(clients),
      onError: (exception, _) => state.failure(exception as GenericException),
    );
  }

  @override
  Future<void> close() {
    _repository.dispose();
    return super.close();
  }
}
