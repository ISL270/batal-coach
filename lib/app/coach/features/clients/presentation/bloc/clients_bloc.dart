import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/paginated_result.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'clients_event.dart';
part 'clients_state.dart';

@injectable
class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final ClientsRepository _repository;

  ClientsBloc(this._repository) : super(const ClientsState()) {
    on<_ClientsSubscriptionRequested>(_onSubscriptionRequested);
    add(_ClientsSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _ClientsSubscriptionRequested event,
    Emitter<ClientsState> emit,
  ) async {
    await emit.forEach(
      _repository.getUpdates(),
      onData: (status) {
        if (status.isSuccess) {
          add(ClientsSearched(state.searchTerm));
        }
        return state;
      },
    );
  }
}
