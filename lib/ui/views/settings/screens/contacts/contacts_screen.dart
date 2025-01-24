// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/views/settings/screens/contacts/screens/add_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  final ContactsController contactsController;
  const ContactsScreen({
    super.key,
    required this.contactsController,
  });

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
    widget.contactsController.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: SafeArea(
          child: Padding(
        padding: AppSpacings.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: ListenableBuilder(
              listenable: widget.contactsController,
              builder: (context, child) {
                if (widget.contactsController.contacts.isEmpty) {
                  return Center(
                    child: Text('No Contacts'),
                  );
                }
                return ListView.builder(
                  itemCount: widget.contactsController.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = widget.contactsController.contacts[index];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 40,
                      leading: Jazzicon.getIconWidget(Jazzicon.getJazziconData(
                          40,
                          address: contact.address)),
                      title: Text(contact.name),
                      subtitle: Text(formatAddress(contact.address)),
                    );
                  },
                );
              },
            )),
            FilledButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddContactScreen(
                        contactsController: widget.contactsController),
                  ));
                },
                child: const Text('Add contact'))
          ],
        ),
      )),
    );
  }
}
