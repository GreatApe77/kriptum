// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kriptum/controllers/import_wallet_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';

class ImportWalletPage extends StatelessWidget {
  final ImportWalletController importWalletController;
  ImportWalletPage({
    super.key,
    required this.importWalletController,
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
            if(importWalletController.loading){
              return BasicLoading();
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
                        controller: confirmPasswordTextController,
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
                            await importWalletController.importWallet(
                                mnemonic: mnemonicTextController.text,
                                password: passwordTextController.text);
                            GoRouter.of(context).push(AppRoutes.home);
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
