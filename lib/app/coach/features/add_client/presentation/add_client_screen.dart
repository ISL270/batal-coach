import 'package:btl/app/coach/features/add_client/presentation/bloc/add_client_cubit.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/core/extension_methods/context_x.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:go_router/go_router.dart';
// part 'widgets/client_category_widget.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({super.key});

  static const name = 'AddClient';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddClientCubit(getIt.get<ClientsRepository>()),
      child: BlocListener<AddClientCubit, AddClientState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.clientAdded)),
            );
            context.pop();
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(context.l10n.wentWrong),
            ));
          }
        },
        child: BlocBuilder<AddClientCubit, AddClientState>(
          builder: (context, state) {
            return Screen(
              appBar: AppBar(
                centerTitle: true,
                title: Text(context.l10n.addClient),
              ),
              body: SingleChildScrollView(
                child: Column(
                  spacing: 30.h,
                  children: const [
                    _FNameField(),
                    _LNameField(),
                    _MailField(),
                    _PhoneNumberField(),
                    // const _ClientCategoryWidget(),
                    _AddClientButton()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FNameField extends StatelessWidget {
  const _FNameField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddClientCubit, AddClientState, Name>(
      selector: (state) => state.fName,
      builder: (context, name) => Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: TextField(
          onChanged: (fName) => context.read<AddClientCubit>().fNameChanged(fName),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: context.l10n.fName,
            errorText: name.displayError == null ? null : context.tr(name.displayError!.name),
          ),
        ),
      ),
    );
  }
}

class _MailField extends StatelessWidget {
  const _MailField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClientCubit, AddClientState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<AddClientCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: context.l10n.email.capitalized,
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
          ),
        );
      },
    );
  }
}

class _LNameField extends StatelessWidget {
  const _LNameField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddClientCubit, AddClientState, Name>(
      selector: (state) => state.lName,
      builder: (context, name) => TextField(
        onChanged: (lName) => context.read<AddClientCubit>().lNameChanged(lName),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: context.l10n.lName,
          errorText: name.displayError == null ? null : context.tr(name.displayError!.name),
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddClientCubit, AddClientState, PhoneNumber>(
      selector: (state) => state.phoneNumber,
      builder: (context, phoneNumber) => TextField(
        onChanged: (phone) => context.read<AddClientCubit>().phoneChanged(phone),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(15),
        ],
        decoration: InputDecoration(
          labelText: context.l10n.pNumber,
          errorText: phoneNumber.displayError == null
              ? null
              : context.tr(context.l10n.phoneNumberRequired),
        ),
      ),
    );
  }
}

class _AddClientButton extends StatelessWidget {
  const _AddClientButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddClientCubit, AddClientState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          context.scaffoldMessenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        final coachEmail = getIt.authBloc.state.user!.email;
        return Button.filled(
          maxWidth: true,
          shape: ButtonShape.roundedCorners,
          isLoading: state.status.isLoading,
          density: ButtonDensity.comfortable,
          onPressed:
              state.isValid ? () => context.read<AddClientCubit>().saveClient(coachEmail) : null,
          label: context.l10n.add,
        );
      },
    );
  }
}
