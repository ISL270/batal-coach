import 'package:btl/app/coach/features/clients/data/models/client_rm.dart';

abstract interface class ClientsRemoteSource {
  Stream<List<ClientRM>> get stream;

  void dispose();
}
