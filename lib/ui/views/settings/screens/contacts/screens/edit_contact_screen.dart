import 'package:flutter/material.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/domain/models/contact.dart';

class EditContactScreen extends StatelessWidget {
  final Contact contact;
  
  const EditContactScreen(
      {super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
    );
  }
}
