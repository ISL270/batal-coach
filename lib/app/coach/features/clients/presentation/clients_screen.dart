import 'package:btl/app/coach/features/clients/presentation/bloc/clients_bloc.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  static const name = 'clients';

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: BlocBuilder<ClientsBloc, ClientsState>(
        builder: (context, state) => ListView.separated(
          itemBuilder: (context, i) => ListTile(
            title: Text(state.clients[i].name),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: state.clients.length,
        ),
      ),
    );
  }
}
