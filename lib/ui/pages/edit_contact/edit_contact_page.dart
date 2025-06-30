import 'package:flutter/material.dart';

import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/ethereum_address_text_field.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({
    super.key,
    required this.contact,
  });

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  // A GlobalKey to uniquely identify the Form widget and allow validation.
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields. They are initialized in initState and disposed in dispose.
  late final TextEditingController _nameTextController;
  late final TextEditingController _addressTextController;

  // A mutable copy of the contact to hold edits.
  late Contact _contactToBeEdited;

  // State variable to toggle between viewing and editing modes.
  bool _isViewOnlyMode = true;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers and the contact copy with the initial data from the widget.
    // This is done in initState because it's called only once when the state object is created.
    _nameTextController = TextEditingController(text: widget.contact.name);
    _addressTextController = TextEditingController(text: widget.contact.address);
    _contactToBeEdited = widget.contact.copyWith();
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    // to free up resources and prevent memory leaks.
    _nameTextController.dispose();
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        actions: [
          IconButton(
            onPressed: _toggleViewOnlyMode,
            // The icon changes based on the current mode.
            icon: Icon(_isViewOnlyMode ? Icons.edit : Icons.cancel),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextFormField(
                readOnly: _isViewOnlyMode,
                onChanged: (value) => _contactToBeEdited.name = value,
                //validator: (value) =>
                //    ContactValidatorController.validateName(value ?? ''),
                controller: _nameTextController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(height: 24),
              Text(
                'Address',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              EthereumAddressTextField(
                controller: _addressTextController,
                readOnly: _isViewOnlyMode,
              ),
              const SizedBox(height: 24),
              // Conditionally render the action buttons based on the mode.
              if (!_isViewOnlyMode)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: () => _triggerEditContact(context),
                      child: const Text('Edit contact'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => _showDeleteContactModal(context),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleViewOnlyMode() {
    // Use setState to rebuild the widget with the new mode value.
    setState(() {
      _isViewOnlyMode = !_isViewOnlyMode;
      // If we cancel the edit, revert the text fields to the original contact data.
      if (_isViewOnlyMode) {
        _nameTextController.text = widget.contact.name;
        _addressTextController.text = widget.contact.address;
        _contactToBeEdited = widget.contact.copyWith();
      }
    });
  }

  Future<void> _triggerEditContact(BuildContext context) async {
    // Validate the form before proceeding.
    if (!_formKey.currentState!.validate()) return;

    /* await widget.contactsController.updateContact(
      contactId: widget.contact.id!,
      editedContactData: _contactToBeEdited,
      onSuccess: () => _onSuccessEditAccount(context),
      onFail: () => _onFailEditContact(context),
    ); */
  }

  void _showDeleteContactModal(BuildContext context) {
    final buttonTextSize = Theme.of(context).textTheme.bodyLarge?.fontSize;
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: buttonTextSize),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => _triggerDeleteContact(context),
              child: Text(
                'Delete',
                style: TextStyle(fontSize: buttonTextSize),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _triggerDeleteContact(BuildContext context) async {
    //await widget.contactsController.deleteContact(
    //  contact: widget.contact,
    //  onSuccess: () => _onSuccessDeleteContact(context),
    //  onFail: () => _onFailDeleteContact(context),
    //);
  }

  void _onSuccessEditAccount(BuildContext context) {
    Navigator.of(context).pop();
    //TODO
  }

  void _onFailEditContact(BuildContext context) {
    //TODO
  }

  void _onSuccessDeleteContact(BuildContext context) {
    // Pop the modal bottom sheet first, then the edit Page.
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    //TODO
  }

  void _onFailDeleteContact(BuildContext context) {
    //TODO
  }
}
