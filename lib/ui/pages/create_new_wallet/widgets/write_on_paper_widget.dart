import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/create_new_wallet/create_new_wallet_bloc.dart';
import 'package:kriptum/ui/pages/home/home_page.dart';
import 'package:kriptum/ui/pages/home_wrapper/home_wrapper_page.dart';

import 'package:kriptum/ui/widgets/linear_check_in_progress_bar_widget.dart';

class WriteOnPaperStep3Screen extends StatelessWidget {
  const WriteOnPaperStep3Screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final mnemonicAsList = exampleMnemonic.split(' ');
    //final firstColumn = mnemonicAsList.take(6).toList();
    // final secondColumn = mnemonicAsList.skip(6).toList();
    return BlocListener<CreateNewWalletBloc, CreateNewWalletState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == CreateNewWalletStatus.failure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred')),
            );
        } else if (state.status == CreateNewWalletStatus.success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeWrapperPage(),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearCheckInProgressBar(
            currentDot: 3,
          ),
          const Text(
            'Write down your Secret Recovery Phrase',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'This is your Secret Recovery Phrase. Write it down on paper and keep it in a safe place. You will be asked to re-enter this phrase (in order) on the next step.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Card.outlined(
            margin: const EdgeInsets.all(8),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<CreateNewWalletBloc, CreateNewWalletState>(
                    builder: (context, state) {
                  final mnemonicAsList = state.mnemonic.split(' ');

                  final firstColumn = mnemonicAsList.take(6).toList();
                  final secondColumn = mnemonicAsList.skip(6).toList();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: firstColumn
                            .asMap()
                            .entries
                            .map(
                              (entry) => Chip(
                                  label:
                                      Text('${entry.key + 1}. ${entry.value}')),
                            )
                            .toList(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: secondColumn
                            .asMap()
                            .entries
                            .map(
                              (entry) => Chip(
                                  label:
                                      Text('${entry.key + 7}. ${entry.value}')),
                            )
                            .toList(),
                      ),
                    ],
                  );
                })),
          ),
          const SizedBox(height: 24),
          BlocBuilder<CreateNewWalletBloc, CreateNewWalletState>(
            buildWhen: (previous, current) => current.status != previous.status,
            builder: (context, state) {
              return FilledButton(
                onPressed: state.status == CreateNewWalletStatus.loading
                    ? null
                    : () => _triggerSaveAccount(context),
                child: Text(
                  state.status == CreateNewWalletStatus.loading
                      ? 'Saving...'
                      : 'I backed up my keys',
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _triggerSaveAccount(BuildContext context) async {
    context.read<CreateNewWalletBloc>().add(ConfirmBackupEvent());
    /*   await _createNewWalletController.saveAccounts(
      onSuccess: () async {
        await settingsController.setIsLockedWallet(false);
        if (!context.mounted) return;
        await GoRouter.of(context).pushReplacement(AppRoutes.home);
      },
      onFail: () {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
              buildErrorSnackBar(context, 'Error while Saving Account'));
      },
    ); */
  }
}
