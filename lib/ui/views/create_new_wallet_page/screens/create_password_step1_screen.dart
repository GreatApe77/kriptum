import 'package:flutter/material.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/password_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/ui/shared/widgets/build_error_snack_bar.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/shared/widgets/linear_check_in_progress_bar.dart';
import 'package:kriptum/ui/shared/controllers/password_validator_controller.dart';

class CreatePasswordStep1Screen extends StatelessWidget {
  final PasswordController _passwordController;
  final SettingsController _settingsController;
  final CreateWalletStepsController _createWalletStepsController;
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final CreateNewWalletController _createNewWalletController;
  final formKey = GlobalKey<FormState>();
  CreatePasswordStep1Screen(
      {super.key,
      required CreateWalletStepsController stepController,
      required CreateNewWalletController createNewWalletController,
      required SettingsController settingsController,
      required PasswordController passwordController})
      : _settingsController = settingsController,
        _createWalletStepsController = stepController,
        _createNewWalletController = createNewWalletController,
        _passwordController = passwordController;

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
                  FilledButton(
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
      ScaffoldMessenger.of(context)
          .showSnackBar(buildErrorSnackBar(context, 'Passwords don\'t match'));
      return;
    }
    _passwordController.setPassord(passwordTextController.text);
    await _createNewWalletController.createNewWalletWithAccounts(
      password: passwordTextController.text,
      settingsController: _settingsController,
      onFail: () {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              'Error while computing new wallet',
              
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
          ));
        return;
      },
      onSuccess: () async {
        await _settingsController.setContainsWallet(true);
        _createWalletStepsController.nextStep();
      },
    );
  }
}
