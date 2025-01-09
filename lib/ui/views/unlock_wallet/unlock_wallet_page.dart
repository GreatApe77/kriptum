import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/erase_wallet_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/controllers/unlock_wallet_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/views/unlock_wallet/widgets/erase_wallet_dialog.dart';

class UnlockWalletPage extends StatelessWidget {
  final UnlockWalletController unlockWalletController;
  final SettingsController settingsController;
  final EraseWalletController eraseWalletController;
  UnlockWalletPage(
      {super.key,
      required this.unlockWalletController,
      required this.settingsController,
      required this.eraseWalletController});
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: unlockWalletController,
          builder: (context, child) {
            if (unlockWalletController.isLoading) {
              return const BasicLoading();
            }
            return Padding(
              padding: AppSpacings.horizontalPadding,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordTextController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Password')),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                          onPressed: () => _triggerUnlockWallet(context),
                          child: const Text('UNLOCK')),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Wallet won\' unlock? You can ERASE your current wallet and setup a new one',
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                          onPressed: () => _showDeleteWalletModal(context),
                          child: const Text('Reset Wallet'))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _triggerEraseWallet(BuildContext context) async {
    await eraseWalletController.eraseWallet();
    await settingsController.clearWalletConfig();
    GoRouter.of(context).pushReplacement(AppRoutes.setup);
  }

  void _showDeleteWalletModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ListenableBuilder(
          listenable: eraseWalletController,
          builder: (context,child) {
            return EraseWalletDialog(
              isLoading: eraseWalletController.isLoading,
              onCancel: () {
                Navigator.pop(context);
              },
              onContinue: () => _triggerEraseWallet(context),
            );
          }
        );
      },
    );
  }

  void _onWrongPassword(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        content: Text('Wrong Password!')));
  }

  _triggerUnlockWallet(BuildContext context) async {
    unlockWalletController.unlockWallet(
      password: passwordTextController.text,
      accountIndex: settingsController.settings.lastConnectedIndex,
      onWrongPassword: () => _onWrongPassword(context),
      onSuccess: () {
        GoRouter.of(context).pushReplacement(AppRoutes.home);
      },
    );
  }
}
