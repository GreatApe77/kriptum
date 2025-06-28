import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/create_new_wallet/create_new_wallet_bloc.dart';
import 'package:kriptum/ui/widgets/linear_check_in_progress_bar_widget.dart';

class SecureWalletStep2Screen extends StatelessWidget {
  const SecureWalletStep2Screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearCheckInProgressBar(
          currentDot: 2,
        ),
        const Icon(
          Icons.lock,
          size: 42,
        ),
        const Text(
          'Secure your wallet',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        const Text(
          'Secure your wallet\'s ',
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => _showSecretRecoveryPhraseDialog(context),
          child: Text(
            'Secret Recovery Phrase',
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: TextButton.icon(
            onPressed: () => _showWhyItsImportantDialog(context),
            icon: const Icon(Icons.info),
            label: const Text('Why is it important?'),
          ),
        ),
        Expanded(
          child: Card.outlined(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Text Explaining why its important'),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                          onPressed: () {
                            context.read<CreateNewWalletBloc>().add(
                                  AdvanceToStep3Event(),
                                );
                          },
                          child: const Text('Start')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        //child: Text('Why is it important?'))
      ],
    );
  }

  _showSecretRecoveryPhraseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            'What is a \'Secret Recovery Phrase\'',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'A Secret Recovery Phrase is a set of twelve words that contains all the information about your wallet, including your funds. It\'s like a secret code used to access your entire wallet.',
                  textAlign: TextAlign.center),
              Text(
                  'You must keep your Secret Recovery Phrase secret and safe. If someone gets Your Secret Recovery Phrase,they\'ll gain control over your accounts. ',
                  textAlign: TextAlign.center),
              Text(
                'Save it in a place where only you can access it. If you lose it, you cannot recover it.',
                textAlign: TextAlign.center,
              )
            ],
          ),
          //icon: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
        );
      },
    );
  }

  _showWhyItsImportantDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            'Protect your wallet',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Don\'t risk losing your funds. Protect your wallet by saving your Secret Recovery Phrase in a place you trust.\nIt\'s the only way to recover your wallet if you get locked out of the app or get a new device.',
            textAlign: TextAlign.center,
          ),
          //icon: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
        );
      },
    );
  }
}
