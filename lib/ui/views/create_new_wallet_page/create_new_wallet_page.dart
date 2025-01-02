import 'package:flutter/material.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/screens/create_password_step1_screen.dart';

class CreateNewWalletPage extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;

  CreateNewWalletPage({
    super.key,
    required CreateWalletStepsController stepController,
  }) : _createWalletStepsController = stepController;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Padding(
          padding: AppSpacings.horizontalPadding,
          child: CreatePasswordStep1Screen(
            stepController: _createWalletStepsController,
          )),
          Text('Page 2'),
          Text('Page 3')
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
