// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:kriptum/controllers/accounts_controller.dart';
import 'package:kriptum/ui/shared/controllers/copy_to_clipboard_controller.dart';

class ReceivePage extends StatefulWidget {
  
  final CurrentAccountController currentAccountController;

  ReceivePage({
    super.key,
    required this.currentAccountController,
  });

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final CopyToClipboardController copyToClipboardController =
      CopyToClipboardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Receive',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text('Network')
                      ],
                    )),
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(height: 24,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SegmentedButton(onSelectionChanged: (p0) {}, segments: const [
                      ButtonSegment<int>(
                          value: 1, label: Text('Scan QR code')),
                      ButtonSegment<int>(
                          value: 2, label: Text('Your QR code'))
                    ], selected: const {
                      2
                    }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        child: QrImageView(
                          data: widget.currentAccountController.connectedAccount!.address,
                          version: QrVersions.auto,
                          size: 250.0,

                        ),
                      ),
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Account ${widget.currentAccountController.connectedAccount!.accountIndex + 1}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        '${widget.currentAccountController.connectedAccount?.address}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            copyToClipboardController.copyToClipboard(
                          content: widget.currentAccountController.connectedAccount!.address,
                          onCopied: (content) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content:
                                        Text('Address copied to clipboard')));
                          },
                        ),
                        label: const Text('Copy address'),
                        icon: const Icon(Icons.copy),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

