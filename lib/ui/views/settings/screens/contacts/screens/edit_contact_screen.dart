import 'package:flutter/material.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/contact_validator_controller.dart';
import 'package:kriptum/ui/shared/controllers/eth_address_validator_controller.dart';

class EditContactScreen extends StatelessWidget {
  final isViewOnlyMode = ValueNotifier<bool>(true);
  final Contact contact;
  final ContactsController contactsController;
  TextEditingController nameTextController;
  TextEditingController addressTextController;

  EditContactScreen(
      {super.key, required this.contact, required this.contactsController})
      : nameTextController = TextEditingController(text: contact.name),
        addressTextController = TextEditingController(text: contact.address);

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
            return ListView(children: [
              Text(
                'Name',
                style: labelStyle,
              ),
              TextFormField(
                readOnly: isViewOnlyMode.value,
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
                            onPressed: () {},
                            child: const Text('Edit contact')),
                        TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.error),
                            onPressed: () => _showDeleteContactModal(context),
                            child: const Text('Delete')),
                      ],
                    )
            ]);
          },
        ),
      ),
    );
  }
  void _triggerEditContact(BuildContext context){
    
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
                onPressed: () => {},
                child: Text(
                  'Delete',
                  style: TextStyle(fontSize: buttonTextSize),
                )),
          ],
        ),
      ),
    );
  }
  void _triggerDeleteContact(BuildContext context){
    
  }
  void _toggleViewOnlyMode() {
    isViewOnlyMode.value = !isViewOnlyMode.value;
  }
}
