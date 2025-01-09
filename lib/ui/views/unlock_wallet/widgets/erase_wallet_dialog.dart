import 'package:flutter/material.dart';

class EraseWalletDialog extends StatelessWidget {
  final Function() onCancel;
  final Function() onContinue;
  const EraseWalletDialog(
      {super.key, required this.onCancel, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_rounded,size: 64,),
          Text('Are you sure you want to erase your wallet?',textAlign: TextAlign.center,)
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
              'Your current wallet,accounts and assets will be removed from this app permanently. This action cannot be undone.',textAlign: TextAlign.center),
          const SizedBox(
            height: 24,
          ),
          const Text(
              'You can ONLY recover this wallet with your Secret Recovery Phrase which must be your responsability.',textAlign: TextAlign.center),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () => onContinue(),
              child: const Text('I understand, continue')),
          const SizedBox(
            height: 12,
          ),
          TextButton(onPressed: () => onCancel(), child: const Text('Cancel')),
        ],
      ),
    );
  }
}
