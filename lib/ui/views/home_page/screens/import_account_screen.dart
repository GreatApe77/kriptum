import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/accounts/accounts_controller.dart';
import 'package:kriptum/controllers/password_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/private_key_validator_controller.dart';
import 'package:kriptum/ui/shared/widgets/basic_loading.dart';
import 'package:kriptum/ui/shared/widgets/build_error_snack_bar.dart';

class ImportAccountScreen extends StatelessWidget {
  final AccountsController accountsController;
  final TextEditingController privateKeyController = TextEditingController();
  final PasswordController passwordController;
  final formKey = GlobalKey<FormState>();
  ImportAccountScreen(
      {super.key,
      required this.accountsController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            child: ListenableBuilder(
                listenable: accountsController,
                builder: (context, child) {
                  if (accountsController.importLoading) {
                    return const BasicLoading();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Container(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: AppSpacings.horizontalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 36,
                                        ))
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.file_download_outlined,
                                    size: 72,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'Import account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                      'Imported accounts are viewable in your wallet but are not recoverable with your Kriptum Secret Recovery Phrase.'),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                      'Learn more about imported accounts here.')
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: AppSpacings.horizontalPadding,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Paste your private key string',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Form(
                                key: formKey,
                                child: TextFormField(
                                  validator: (privateKey) => PrivateKeyValidatorController.validate(privateKey ?? ''),
                                  controller: privateKeyController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FilledButton(
                                      onPressed: () =>
                                          _triggerImportAccount(context),
                                      child: const Text('IMPORT'))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _triggerImportAccount(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;
    await accountsController.importAccountFromPrivateKey(
      privateKey: privateKeyController.text,
      password: passwordController.password,
      onAlreadyExistingAccount: () {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(buildErrorSnackBar(context,'Account already imported!'));
      },
      onSuccess: () async{
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 750));
        if(!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primaryFixed,
              content: const Text('Account Imported Successfully')));
      },
      onFail: () {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(buildErrorSnackBar(context, 'Error while importing account'));
      },
    );
  }
}
