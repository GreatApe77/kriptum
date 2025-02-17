import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/widgets/build_error_snack_bar.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/widgets/linear_check_in_progress_bar.dart';

class WriteOnPaperStep3Screen extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;
  final CreateNewWalletController _createNewWalletController;
  final SettingsController settingsController;
  const WriteOnPaperStep3Screen(
      {super.key,
      required CreateWalletStepsController stepController,
      required CreateNewWalletController createNewWalletController,
      required this.settingsController})
      : _createWalletStepsController = stepController,
        _createNewWalletController = createNewWalletController;

  @override
  Widget build(BuildContext context) {
    // final mnemonicAsList = exampleMnemonic.split(' ');
    //final firstColumn = mnemonicAsList.take(6).toList();
    // final secondColumn = mnemonicAsList.skip(6).toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearCheckInProgressBar(
          currentDot: _createWalletStepsController.step + 1,
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
              child: ListenableBuilder(
                  listenable: _createNewWalletController,
                  builder: (context, child) {
                    final mnemonicAsList =
                        _createNewWalletController.generatedMnemonic.split(' ');

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
                                    label: Text(
                                        '${entry.key + 1}. ${entry.value}')),
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
                                    label: Text(
                                        '${entry.key + 7}. ${entry.value}')),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  })),
        ),
        const SizedBox(height: 24),
        FilledButton(
            onPressed: () => _triggerSaveAccount(context),
            child: const Text('I backed up my keys'))
      ],
    );
  }

  void _triggerSaveAccount(BuildContext context) async {
    await _createNewWalletController.saveAccounts(
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
    );
  }
}
