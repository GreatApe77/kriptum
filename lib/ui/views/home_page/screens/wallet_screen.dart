import 'package:flutter/material.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';

import 'package:kriptum/controllers/accounts_controller.dart.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/views/home_page/controllers/copy_to_clipboard_controller.dart';
import 'package:kriptum/ui/views/home_page/widgets/account_viewer_btn.dart';

class WalletScreen extends StatefulWidget {
  final AccountsController accountsController;
  final SettingsController settingsController;
  final AccountBalanceController accountBalanceController;
  WalletScreen({
    super.key,
    required this.accountsController,
    required this.settingsController,
    required this.accountBalanceController,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final CopyToClipboardController copyToClipboardController =
      CopyToClipboardController();

  @override
  void didUpdateWidget(covariant WalletScreen oldWidget) {
    
    super.didUpdateWidget(oldWidget);
    widget.accountBalanceController.loadAccountBalance(
        widget.accountsController.connectedAccount!.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: AccountViewerBtn(account: widget.accountsController.connectedAccount!, onPressed: () {  },),
        actions: [
          IconButton(
              onPressed: () => copyToClipboardController.copyToClipboard(
                    content:
                        widget.accountsController.connectedAccount!.address,
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
                                          size: 80,
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          'Public address ${formatAddress(widget.accountsController.connectedAccount!.address)} copied to clipboard',
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
      body: Container(
          padding: AppSpacings.horizontalPadding,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListenableBuilder(
                  listenable: widget.accountBalanceController,
                  builder: (context, child) {
                    return Flexible(
                      child: Text(
                        'ETH ${formatEther(widget.accountBalanceController.balance)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 36),
                      ),
                    );
                  }),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove_red_eye_rounded))
            ],
          )),
    );
  }
}

