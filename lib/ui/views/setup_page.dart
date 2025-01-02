import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTitleAppBar(),
      body: Padding(
        padding: AppSpacings.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Wallet setup',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Import an existing wallet or create a new one',
              textAlign: TextAlign.center,
              style: TextStyle(
                
                fontSize: 16
              ),
            ),
            Expanded(child: Container()),
            OutlinedButton(

              onPressed: () => _navigateToImportWalletPage(context), child: const Text('Import using Secret Recovery Phrase')),
            const SizedBox(height: 8,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                
              ),
              onPressed: () => _navigateToCreateNewWalletPage(context), child: const Text('Create a new wallet')),
            const SizedBox(height: 42,),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateNewWalletPage(BuildContext context){
      context.push(AppRoutes.createNewWallet);
  }
  void _navigateToImportWalletPage(BuildContext context){
      context.push(AppRoutes.importWallet);
  }
}
