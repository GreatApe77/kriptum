// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kriptum/controllers/accounts_controller.dart.dart';

class ReceivePage extends StatelessWidget {
  final AccountsController accountsController;
  const ReceivePage({
    super.key,
    required this.accountsController,
  });

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
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          'Receive',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text('Network')
                      ],
                    )),
                    IconButton(onPressed: () {}, icon: Icon(Icons.close))
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SegmentedButton(onSelectionChanged: (p0) {}, segments: [
                      ButtonSegment<int>(value: 1, label: Text('Scan QR code')),
                      ButtonSegment<int>(value: 2, label: Text('Your QR code'))
                    ], selected: {
                      2
                    }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: SizedBox(
                        child: Container(
                          color: Colors.red,
                        ),
                        height: 20,
                        width: 20,
                      ),
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Account ${accountsController.connectedAccount!.accountIndex + 1}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        '${accountsController.connectedAccount?.address}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton.icon(onPressed: () {
                        
                      },label: Text('Copy address'), icon: Icon(Icons.copy),)
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class ScanOrDisplayQrCodeTab extends StatelessWidget {
  const ScanOrDisplayQrCodeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
