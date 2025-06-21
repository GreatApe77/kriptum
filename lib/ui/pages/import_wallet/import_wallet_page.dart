// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/factories/mnemonic_factory.dart';
import 'package:kriptum/domain/factories/password_factory.dart';
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

class _ImportWalletView extends StatefulWidget {
  _ImportWalletView();

  @override
  State<_ImportWalletView> createState() => _ImportWalletViewState();
}

class _ImportWalletViewState extends State<_ImportWalletView> {
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
                    final result =
                        injector.get<MnemonicFactory>().create(value ?? '');
                    if (result.isFailure) return result.failure;
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) {
                    final result =
                        injector.get<PasswordFactory>().create(password ?? '');
                    if (result.isFailure) return result.failure;
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'New Password',
                    label: Text('New Password'),
                    border: OutlineInputBorder(),
                  ),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (confirmPassword) {
                    if (confirmPassword != passwordTextController.text) {
                      return 'Passwords don\'t match';
                    }
                    final result = injector
                        .get<PasswordFactory>()
                        .create(confirmPassword ?? '');
                    if (result.isFailure) return result.failure;
                    return null;
                  },
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
}
