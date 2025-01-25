import 'package:flutter/material.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/contact_validator_controller.dart';
import 'package:kriptum/ui/shared/controllers/eth_address_validator_controller.dart';
import 'package:kriptum/ui/shared/widgets/build_action_snack_bar.dart';
import 'package:kriptum/ui/shared/widgets/build_error_snack_bar.dart';

class EditContactScreen extends StatelessWidget {
  final isViewOnlyMode = ValueNotifier<bool>(true);
  final Contact contactToBeEdited;
  final Contact originalContact;
  final ContactsController contactsController;
  TextEditingController nameTextController;
  TextEditingController addressTextController;
  final formKey = GlobalKey<FormState>();
  EditContactScreen(
      {super.key, required Contact contact, required this.contactsController})
      : nameTextController = TextEditingController(text: contact.name),
        addressTextController = TextEditingController(text: contact.address),
        contactToBeEdited = contact.copyWith(),
        originalContact = contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        actions: [
          IconButton(
              onPressed: () => _toggleViewOnlyMode(),
              icon: ListenableBuilder(
                listenable: isViewOnlyMode,
                builder: (context, child) {
                  if (isViewOnlyMode.value) {
                    return const Icon(Icons.edit);
                  }
                  return const Icon(Icons.cancel);
                },
              )),
        ],
      ),
      body: Padding(
        padding: AppSpacings.horizontalPadding,
        child: ListenableBuilder(
          listenable: isViewOnlyMode,
          builder: (context, child) {
            final labelStyle = Theme.of(context).textTheme.titleMedium;
            return Form(
              key: formKey,
              child: ListView(children: [
                Text(
                  'Name',
                  style: labelStyle,
                ),
                TextFormField(
                  readOnly: isViewOnlyMode.value,
                  onChanged: (value) => contactToBeEdited.name = value,
                  validator: (value) =>
                      ContactValidatorController.validateName(value ?? ''),
                  controller: nameTextController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text('Address', style: labelStyle),
                TextFormField(
                  onChanged: (value) => contactToBeEdited.address = value,
                  readOnly: isViewOnlyMode.value,
                  validator: (value) =>
                      EthAddressValidatorController.validateEthAddress(
                          value ?? ''),
                  controller: addressTextController,
                  decoration:
                      const InputDecoration(hintText: 'Public address (0x)'),
                ),
                const SizedBox(
                  height: 24,
                ),
                isViewOnlyMode.value
                    ? const SizedBox.shrink()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                              onPressed: () => _triggerEditContact(context),
                              child: const Text('Edit contact')),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.error),
                              onPressed: () => _showDeleteContactModal(context),
                              child: const Text('Delete')),
                        ],
                      )
              ]),
            );
          },
        ),
      ),
    );
  }

  Future<void> _triggerEditContact(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await contactsController.updateContact(
      contactId: originalContact.id!,
      editedContactData: contactToBeEdited,
      onSuccess: () => _onSuccessEditAccount(context),
      onFail: () => _onFailEditContact(context),
    );
  }

  void _showDeleteContactModal(BuildContext context) {
    final buttonTextSize = Theme.of(context).textTheme.bodyLarge?.fontSize;
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => Padding(
        padding: AppSpacings.horizontalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: buttonTextSize),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
                onPressed: () => _triggerDeleteContact(context),
                child: Text(
                  'Delete',
                  style: TextStyle(fontSize: buttonTextSize),
                )),
          ],
        ),
      ),
    );
  }

  void _triggerDeleteContact(BuildContext context) async {
    await contactsController.deleteContact(
      contact: originalContact,
      onSuccess: () => _onSuccessDeleteContact(context),
      onFail: () => _onFailDeleteContact(context),
    );
  }

  void _onSuccessEditAccount(BuildContext context) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(buildActionSnackBar(context, 'Edited Contact'));
  }

  void _onFailEditContact(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
          buildErrorSnackBar(context, 'Error while editing contact'));
  }

  void _onSuccessDeleteContact(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(buildActionSnackBar(context, 'Deleted Contact'));
  }

  void _onFailDeleteContact(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
          buildErrorSnackBar(context, 'Error while deleting contact'));
  }

  void _toggleViewOnlyMode() {
    isViewOnlyMode.value = !isViewOnlyMode.value;
  }
}
