import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/clients_repository.dart';
import 'package:btl/app/core/models/bloc_event_transformers.dart';
import 'package:btl/app/core/models/domain/paginated_result.dart';
import 'package:btl/app/core/models/status.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'clients_event.dart';
part 'clients_state.dart';

@injectable
class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final ClientsRepository _repository;

  ClientsBloc(this._repository) : super(const ClientsState()) {
    on<_ClientsSubscriptionRequested>(_onSubscriptionRequested);
    on<ClientsSearched>(_onSearched);
    on<ClientsNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );

    add(_ClientsSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _ClientsSubscriptionRequested event,
    Emitter<ClientsState> emit,
  ) async {
    await emit.forEach(
      _repository.stream(),
      onData: (status) {
        if (status.isSuccess) {
          add(ClientsSearched(state.searchTerm));
        }
        return state;
      },
    );
  }

  Future<void> _onSearched(ClientsSearched event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(
      status: const Loading(),
      searchTerm: event.searchTerm,
    ));

    final searchResult = await _repository.searchClients(
      page: 0,
      event.searchTerm,
      pageSize: state.clients.pageSize,
    );

    emit(state.copyWith(
      status: const Success(null),
      client: PaginatedResult(result: searchResult),
    ));
  }

  Future<void> _onNextPageFetched(
    ClientsNextPageFetched event,
    Emitter<ClientsState> emit,
  ) async {
    if (state.clients.hasReachedMax) return;

    final searchResult = await _repository.searchClients(
      state.searchTerm,
      page: state.clients.page + 1,
      pageSize: state.clients.pageSize,
    );

    emit(state.copyWith(
      status: const Success(null),
      client: state.clients.appendResult(
        searchResult,
        hasReachedMax: searchResult.length < state.clients.pageSize,
      ),
    ));
  }

  @override
  Future<void> close() {
    _repository.dispMethod();
    return super.close();
  }
}
