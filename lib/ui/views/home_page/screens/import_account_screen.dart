import 'package:flutter/material.dart';
import 'package:kriptum/controllers/accounts/accounts_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';

class ImportAccountScreen extends StatelessWidget {
  final AccountsController accountsController;
  const ImportAccountScreen({super.key, required this.accountsController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: Padding(
              padding: AppSpacings.horizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              size: 36,
                            ))
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        size: 72,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Import account',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Imported accounts are viewable in your wallet but are not recoverable with your Kriptum Secret Recovery Phrase.'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Learn more about imported accounts here.')
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Paste your private key string',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(onPressed: () {}, child: Text('IMPORT'))
                    ],
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
