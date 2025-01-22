import 'package:flutter/material.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/ui/views/send/widgets/transaction_info_dialog.dart';

void main(List<String> args) {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TransactionInfoDialog(
                    toAddress: '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65',
                    transactionHash: '0x9c9e1b5ee86f3b11e741960569dc7b69232735ce86c0a590645eca0166c8fa22',
                    from: Account(accountIndex: 40, address: '0x70997970C51812dc3A010C7d01b50e0d17dc79C8', encryptedJsonWallet: ''),
                    amount: BigInt.parse('4650000000000000000'),
                    network: Network(
                        id: 4002,
                        rpcUrl: 'https://rpc.testnet.fantom.network',
                        name: 'Fantom Testnet',
                        ticker: 'FTM',
                        currencyDecimals: 18),
                  );
                },
              );
            },
            child: const Text('Show')),
      )),
    );
  }
}
