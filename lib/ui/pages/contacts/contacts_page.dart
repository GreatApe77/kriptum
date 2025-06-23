import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/blocs/contacts/contacts_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/shared/utils/format_address.dart';
import 'package:kriptum/ui/pages/add_contact/add_contact_page.dart';
import 'package:kriptum/ui/tokens/spacings.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsBloc>(
      create: (context) => ContactsBloc(
        injector.get(),
      )..add(ContactsRequested()),
      child: _ContactsView(),
    );
  }
}

class _ContactsView extends StatelessWidget {
  const _ContactsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacings.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: BlocBuilder<ContactsBloc, ContactsState>(
                  builder: (context, state) {
                    if (state.status == ContactsStatus.loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.filteredContacts.isEmpty) {
                      return Center(
                        child: Text('No Contacts'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.filteredContacts.length,
                      itemBuilder: (context, index) {
                        final contact = state.filteredContacts[index];
                        return ListTile(
                          //onTap: () => _navigateToEditContactPage(
                          //    context, widget.contactsController.contacts[index]),
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 40,
                          leading: Jazzicon.getIconWidget(
                            Jazzicon.getJazziconData(
                              40,
                              address: contact.address,
                            ),
                          ),
                          title: Text(contact.name),
                          subtitle: Text(
                            formatAddress(contact.address),
                          ),
                        );
                      },
                    );
                  },
                ),
/*               child: ListenableBuilder(
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
                        onTap: () => _navigateToEditContactPage(
                            context, widget.contactsController.contacts[index]),
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 40,
                        leading: Jazzicon.getIconWidget(
                            Jazzicon.getJazziconData(40,
                                address: contact.address)),
                        title: Text(contact.name),
                        subtitle: Text(formatAddress(contact.address)),
                      );
                    },
                  );
                },
              ), */
              ),
              FilledButton(
                  onPressed: () {
                    _navigateToAddContactPage(context);
                  },
                  child: const Text('Add contact'))
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAddContactPage(BuildContext context) {
    final contactsBloc = context.read<ContactsBloc>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: contactsBloc,
          child: AddContactPage(),
        ),
      ),
    );
  }
  /* void _navigateToEditContactPage(BuildContext context, Contact contact) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditContactScreen(
          contact: contact, contactsController: widget.contactsController),
    ));
  } */
}
