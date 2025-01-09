// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kriptum/controllers/accounts_controller.dart.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/views/home_page/controllers/copy_to_clipboard_controller.dart';

class WalletScreen extends StatelessWidget {
  final AccountsController accountsController;
  final SettingsController settingsController;
  final CopyToClipboardController copyToClipboardController =
      CopyToClipboardController();
  WalletScreen({
    super.key,
    required this.accountsController,
    required this.settingsController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                    'Account ${settingsController.settings.lastConnectedIndex + 1}'),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
            Text(
              formatAddress(accountsController.connectedAccount!.address),
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => copyToClipboardController.copyToClipboard(
                    content: accountsController.connectedAccount!.address,
                    onCopied: (content) {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Builder(builder: (context) {
                            return FutureBuilder(
                                future: Future.delayed(Duration(seconds: 1))
                                    .then((value) => true),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Navigator.of(context).pop();
                                  }
                                  return AlertDialog(

                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          size: 80
                                          
                                          ,
                                        ),
                                        SizedBox(height: 12,),
                                        Text(
                                          'Public address ${formatAddress(accountsController.connectedAccount!.address)} copied to clipboard',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  );
                                });
                          });
                        },
                      );
                    },
                  ),
              icon: Icon(Icons.copy)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.qr_code_scanner_rounded))
        ],
      ),
    );
  }
}
