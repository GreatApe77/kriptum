import 'package:flutter/material.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/screens/create_password_step1_screen.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/screens/secure_wallet_step2_screen.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/screens/write_on_paper_step3_screen.dart';

class CreateNewWalletPage extends StatelessWidget {
  final SettingsController _settingsController;
  final CreateWalletStepsController _createWalletStepsController;
  final CreateNewWalletController _createNewWalletController;
  CreateNewWalletPage(
      {super.key,
      required CreateWalletStepsController stepController,
      required CreateNewWalletController createNewWalletController,
      required SettingsController settingsController})
      : _settingsController = settingsController,
        _createWalletStepsController = stepController,
        _createNewWalletController = createNewWalletController;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Padding(
          padding: AppSpacings.horizontalPadding,
          child: CreatePasswordStep1Screen(
            settingsController: _settingsController,
            stepController: _createWalletStepsController,
            createNewWalletController: _createNewWalletController,
          )),
      Padding(
          padding: AppSpacings.horizontalPadding,
          child: SecureWalletStep2Screen(
            stepController: _createWalletStepsController,
          )),
      Padding(
          padding: AppSpacings.horizontalPadding,
          child: WriteOnPaperStep3Screen(
            createNewWalletController: _createNewWalletController,
            stepController: _createWalletStepsController,
          )),
    ];
    return Scaffold(
      appBar: buildTitleAppBar(),
      body: ListenableBuilder(
        listenable: _createWalletStepsController,
        builder: (context, child) {
          return pages[_createWalletStepsController.step];
        },
      ),
    );
  }
}
