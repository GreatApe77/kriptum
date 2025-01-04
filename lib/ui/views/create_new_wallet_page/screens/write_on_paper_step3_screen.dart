import 'package:flutter/material.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/widgets/linear_check_in_progress_bar.dart';

final exampleMnemonic =
    'bom dia como vai voce hoje eh sabado amanha domingo depois segunda';

class WriteOnPaperStep3Screen extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;
  const WriteOnPaperStep3Screen({
    super.key,
    required CreateWalletStepsController stepController,
  }) : _createWalletStepsController = stepController;

  @override
  Widget build(BuildContext context) {
    final mnemonicAsList = exampleMnemonic.split(' ');
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearCheckInProgressBar(
            currentDot: _createWalletStepsController.step + 1,
          ),
          const Text(
            'Write down your Secret Recovery Phrase',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'This is your Secret Recovery Phrase. Write it down on paper and keep it in a safe place. You will be asked to re-enter this phrase (in order) on the next step.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Card.outlined(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              
              child: Container(
                height: 200,
                child: GridView.count(
                  
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  
                  
                  children: mnemonicAsList
                      .map((word) => Chip(label: Text(word)))
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
