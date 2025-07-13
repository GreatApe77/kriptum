import 'package:flutter/material.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/ethereum_address_text_field.dart';

class ImportTokensPage extends StatelessWidget {
  const ImportTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ImportTokensPage();
  }
}

class _ImportTokensPage extends StatefulWidget {
  const _ImportTokensPage();

  @override
  State<_ImportTokensPage> createState() => _ImportTokensPageState();
}

class _ImportTokensPageState extends State<_ImportTokensPage> {
  final _tokenAddressTextFieldController = TextEditingController();

  @override
  void dispose() {
    _tokenAddressTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import tokens'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacings.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Token contract address',style: Theme.of(context).textTheme.labelLarge,),
            EthereumAddressTextField(controller: _tokenAddressTextFieldController,hintText: '0x...',),
          ],
        ),
      ),
    );
  }
}
