// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kriptum/controllers/import_wallet_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/password_validator_controller.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/shared/widgets/password_dont_match_alert.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';
import 'package:kriptum/ui/views/import_wallet/controllers/mnemonic_validator_controller.dart';

//test test test test test test test test test test test junk
class ImportWalletPage extends StatelessWidget {
  final ImportWalletController importWalletController;
  final SettingsController settingsController;
  ImportWalletPage({
    super.key,
    required this.importWalletController,
    required this.settingsController,
  });
  final GlobalKey<FormState> formKey = GlobalKey();
  final mnemonicTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTitleAppBar(),
      body: ListenableBuilder(
          listenable: importWalletController,
          builder: (context, child) {
            if (importWalletController.loading) {
              return const BasicLoading();
            }
            return Padding(
              padding: AppSpacings.horizontalPadding,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Import from Secret Recovery Phrase',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        validator: (mnemonic) => MnemonicValidatorController.validateMnemonic(mnemonic),
                        controller: mnemonicTextController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your Secret Recovery Phrase',
                            label: Text('Secret Recovery Phrase'),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordTextController,
                        validator: (password) =>
                            PasswordValidatorController.validLength(password),
                        decoration: const InputDecoration(
                            hintText: 'New Password',
                            label: Text('New Password'),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        obscureText:true,
                        controller: confirmPasswordTextController,
                        validator: (confirmPassword) =>
                            PasswordValidatorController.validLength(
                                confirmPassword),
                        decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            helperText: 'Must be at least 8 characters',
                            label: Text('Confirm Password'),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;
                            if (passwordTextController.text !=
                                confirmPasswordTextController.text) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(buildPasswordDontMatchAlert());
                                  return;
                            }
                            await importWalletController.importWallet(
                                mnemonic: mnemonicTextController.text,
                                password: passwordTextController.text);
                            await settingsController.setContainsWallet(true);
                            await settingsController
                                .changeCurrentAccountIndex(0);
                            GoRouter.of(context)
                                .pushReplacement(AppRoutes.home);
                          },
                          child: const Text('IMPORT'))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
