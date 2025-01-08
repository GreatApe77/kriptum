import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/controllers/unlock_wallet_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';

class UnlockWalletPage extends StatelessWidget {
  final UnlockWalletController unlockWalletController;
  final SettingsController settingsController;
  UnlockWalletPage(
      {super.key,
      required this.unlockWalletController,
      required this.settingsController});
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: unlockWalletController,
          builder: (context, child) {
            if(unlockWalletController.isLoading){
              return BasicLoading();
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
                          onPressed: () {}, child: const Text('Reset Wallet'))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _onWrongPassword(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        print("DEU BOM");
      },
    );
  }
}
