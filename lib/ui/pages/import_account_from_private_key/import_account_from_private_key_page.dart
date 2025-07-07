import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/import_account/import_account_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/shared/utils/show_snack_bar.dart';
import 'package:kriptum/ui/tokens/spacings.dart';

class ImportAccountFromPrivateKeyPage extends StatelessWidget {
  const ImportAccountFromPrivateKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImportAccountBloc>(
      create: (context) => ImportAccountBloc(injector.get()),
      child: const _ImportAccountFromPrivateKeyPage(),
    );
  }
}

class _ImportAccountFromPrivateKeyPage extends StatefulWidget {
  const _ImportAccountFromPrivateKeyPage();

  @override
  State<_ImportAccountFromPrivateKeyPage> createState() => __ImportAccountFromPrivateKeyPageState();
}

class __ImportAccountFromPrivateKeyPageState extends State<_ImportAccountFromPrivateKeyPage> {
  final _formKey = GlobalKey<FormState>();
  final _privateKeyTextController = TextEditingController();

  @override
  void dispose() {
    _privateKeyTextController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            child: BlocConsumer<ImportAccountBloc, ImportAccountState>(
              listener: (context, state) {
                if (state is ImportAccountFailed) {
                  showSnackBar(message: state.errorMessage, context: context, snackBarType: SnackBarType.error);
                }
                if(state is ImportAccountSuccess){
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is ImportAccountLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
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
                                      ),
                                    )
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
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'Import account',
                                    style: Theme.of(context).textTheme.displaySmall,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                      'Imported accounts are viewable in your wallet but are not recoverable with your Kriptum Secret Recovery Phrase.'),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text('Learn more about imported accounts here.')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Paste your private key string',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _privateKeyTextController,
                                  //validator: (privateKey) => PrivateKeyValidatorController.validate(privateKey ?? ''),
                                  //controller: privateKeyController,
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
                                    child: const Text('IMPORT'),
                                    onPressed: () {
                                      context.read<ImportAccountBloc>().add(
                                            ImportAccountRequested(privateKey: _privateKeyTextController.text),
                                          );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
