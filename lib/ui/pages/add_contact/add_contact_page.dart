import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/contacts/contacts_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/factories/ethereum_address_factory.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/ui/tokens/spacings.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _nameTextController = TextEditingController();

  final _addressTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameTextController.dispose();
    _addressTextController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.titleMedium;
    return BlocListener<ContactsBloc, ContactsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ContactsStatus.error) {
          _onError(context, state.errorMessage);
          return;
        }
        _onSuccess(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Contact'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacings.horizontalPadding,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Name',
                    style: labelStyle,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    controller: _nameTextController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Address', style: labelStyle),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      final result = injector
                          .get<EthereumAddressFactory>()
                          .create(value ?? '');
                      if (result.isFailure) {
                        return result.failure;
                      }
                      return null;
                    },
                    controller: _addressTextController,
                    decoration:
                        const InputDecoration(hintText: 'Public address (0x)'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FilledButton(
                      onPressed: () => _triggerAddContact(context),
                      child: const Text('Add Contact'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _triggerAddContact(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    context.read<ContactsBloc>().add(
          ContactInsertionRequested(
            contact: Contact(
                name: _nameTextController.text,
                address: _addressTextController.text),
          ),
        );
  }

  void _onSuccess(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}
