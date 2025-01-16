import 'package:flutter/material.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';

class UpdateAccountAliasScreen extends StatelessWidget {
  final Account account;

  final TextEditingController newAliasNameController;
  UpdateAccountAliasScreen({super.key, required this.account})
      : newAliasNameController = TextEditingController(text: account.alias);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: AppSpacings.horizontalPadding,
        child: Column(
          children: [
            Column(
              children: [
                TextField(
                  controller: newAliasNameController,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  initialValue: account.address,
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Address'),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text('Cancel')),
                ElevatedButton(onPressed: () {
                  String? accountName = newAliasNameController.text.isEmpty? null:newAliasNameController.text;
                  Navigator.pop(context,accountName);
                }, child: Text('Save'))
              ],
            )
          ],
        ),
      )),
    );
  }
}
