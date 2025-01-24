import 'package:flutter/material.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/build_error_snack_bar.dart';

class AddContactScreen extends StatelessWidget {
  AddContactScreen({super.key, required this.contactsController});
  final ContactsController contactsController;
  final nameTextController = TextEditingController();
  final addressTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Contact'),
        ),
        body: SafeArea(
            child: Padding(
          padding: AppSpacings.horizontalPadding,
          child: ListView(
            children: [
              Text(
                'Name',
                style: labelStyle,
              ),
              TextFormField(
                controller: nameTextController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(
                height: 24,
              ),
              Text('Address', style: labelStyle),
              TextFormField(
                controller: addressTextController,
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
        )));
  }

  void _triggerAddContact(BuildContext context) async {
    await contactsController.addContact(
      name: nameTextController.text,
      address: addressTextController.text,
      onSuccess: () => _onSuccess(context),
      onError: () => _onError(context),
      onExistingContact: () => _onExistingContact(context),
    );
  }

  void _onSuccess(BuildContext context) {
    Navigator.of(context).pop();
  }
  void _onError(BuildContext context) {
    ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(buildErrorSnackBar(context, 'Error while adding account'));
  }
  void _onExistingContact(BuildContext context) {
        ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(buildErrorSnackBar(context, 'Contact already added'));

  }
}
