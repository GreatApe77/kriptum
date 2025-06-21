// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kriptum/domain/models/mnemonic.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/main_title_app_bar_widget.dart';

//test test test test test test test test test test test junk

class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ImportWalletView();
  }
}

class _ImportWalletView extends StatelessWidget {
  _ImportWalletView();
  final GlobalKey<FormState> formKey = GlobalKey();
  final mnemonicTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleAppBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacings.horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Import from Secret Recovery Phrase',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: mnemonicTextController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    final mnemonic = Mnemonic.create(value ?? '');
                    if (mnemonic.isFailure) return mnemonic.failure;
                    return null;
                  },
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
                  decoration: const InputDecoration(
                      hintText: 'New Password',
                      label: Text('New Password'),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  obscureText: true,
                  controller: confirmPasswordTextController,
                  //validator: (confirmPassword) =>
                  //  PasswordValidatorController.validLength(
                  //      confirmPassword),
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
                    //onPressed: () => _triggerImportWallet(context),

                    onPressed: () {},
                    child: const Text('IMPORT'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*  void _triggerImportWallet(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (passwordTextController.text != confirmPasswordTextController.text) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(buildErrorSnackBar(context, 'Passwords don\'t match'));
      return;
    }
    await importWalletController.importWalletWithMultipleAccounts(
      settingsController: settingsController,
      mnemonic: mnemonicTextController.text,
      password: passwordTextController.text,
      onError: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('Something went wrong!')));
      },
      onSuccess: () async {
        await settingsController.setContainsWallet(true);
        await settingsController.changeCurrentAccountIndex(0);
        await settingsController.setIsLockedWallet(false);
        passwordController.setPassord(passwordTextController.text);
        if (!context.mounted) return;
        await GoRouter.of(context).pushReplacement(AppRoutes.home);
      },
    );
  } */
}
