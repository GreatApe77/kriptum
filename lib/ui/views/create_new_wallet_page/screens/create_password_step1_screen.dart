import 'package:flutter/material.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/shared/widgets/linear_check_in_progress_bar.dart';

class CreatePasswordStep1Screen extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final CreateNewWalletController _createNewWalletController;
  CreatePasswordStep1Screen(
      {super.key,
      required CreateWalletStepsController stepController,
      required CreateNewWalletController createNewWalletController})
      : _createWalletStepsController = stepController,
        _createNewWalletController = createNewWalletController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _createNewWalletController,
      builder: (context,child) {
        if(_createNewWalletController.loading){
          return const BasicLoading();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearCheckInProgressBar(
                currentDot: _createWalletStepsController.step + 1,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Create password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'This password will unlock your Kriptum wallet only on this device',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    label: Text('New Password'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    helperText: 'Must be at leaset 8 characters',
                    label: Text('Confirm Password'),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed:_triggerCreateWallet,
                  child: Text('Create Wallet')),
            ],
          ),
        );
      }
    );
  }

  Future<void> _triggerCreateWallet() async {
    await _createNewWalletController
        .createNewWallet(confirmPasswordTextController.text);
    _createWalletStepsController.nextStep();
  }
}
