import 'package:flutter/material.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/widgets/linear_check_in_progress_bar.dart';

class SecureWalletStep2Screen extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;
  const SecureWalletStep2Screen({
    super.key,
    required CreateWalletStepsController stepController,
  }) : _createWalletStepsController = stepController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearCheckInProgressBar(
            currentDot: _createWalletStepsController.step+1,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Secure your wallet\'s ',
              
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () => _showSecretRecoveryPhraseDialog(context),
              child: Text('Secret Recovery Phrase',
                
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16),),
            )
          ],
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
        const Expanded(
          child: Card.outlined(
            child: Padding(padding: EdgeInsets.all(16),child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Text Explaining why its important')],
            ),),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        //child: Text('Why is it important?'))
      ],
    );
  }
  _showSecretRecoveryPhraseDialog(BuildContext context){
    showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('What is a \'Secret Recovery Phrase\'',textAlign: TextAlign.center,),
          //icon: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
        );
    },);
  }
  _showWhyItsImportantDialog(BuildContext context){
    showDialog(
      
      context: context, builder: (context) {
        return AlertDialog(
          title: Text('Protect your wallet',textAlign: TextAlign.center,),
          //icon: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
        );
    },);
  }
}
