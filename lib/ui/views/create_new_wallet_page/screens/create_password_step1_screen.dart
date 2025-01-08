import 'package:flutter/material.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/ui/shared/widgets/password_dont_match_alert.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/shared/widgets/linear_check_in_progress_bar.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/password_validator_controller.dart';

class CreatePasswordStep1Screen extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final CreateNewWalletController _createNewWalletController;
  final formKey = GlobalKey<FormState>();
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
        builder: (context, child) {
          if (_createNewWalletController.loading) {
            return const BasicLoading();
          }
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearCheckInProgressBar(
                    currentDot: _createWalletStepsController.step + 1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Create password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'This password will unlock your Kriptum wallet only on this device',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: passwordTextController,
                    validator: (password) =>
                        PasswordValidatorController.validLength(password),
                    obscureText: true,
                    decoration: const InputDecoration(
                        label: Text('New Password'),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: confirmPasswordTextController,
                    validator: (confirmPassword) =>
                        PasswordValidatorController.validLength(
                            confirmPassword),
                    obscureText: true,
                    decoration: const InputDecoration(
                        helperText: 'Must be at leaset 8 characters',
                        label: Text('Confirm Password'),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () => _triggerCreateWallet(context),
                      child: const Text('Create Wallet')),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _triggerCreateWallet(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (confirmPasswordTextController.text != passwordTextController.text) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar( buildPasswordDontMatchAlert());
      return;
    }
    await _createNewWalletController
        .createNewWallet(confirmPasswordTextController.text);
    _createWalletStepsController.nextStep();
  }
}
