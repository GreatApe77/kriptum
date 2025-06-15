import 'package:flutter/material.dart';

import 'package:kriptum/ui/tokens/spacings.dart';

class UnlockWalletPage extends StatelessWidget {
  UnlockWalletPage({
    super.key,
  });
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacings.horizontalPadding,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordTextController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Password')),
                ),
                const SizedBox(
                  height: 32,
                ),
                FilledButton(onPressed: () {}, child: const Text('UNLOCK')),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Wallet won\' unlock? You can ERASE your current wallet and setup a new one',
                  textAlign: TextAlign.center,
                ),
                TextButton(onPressed: () {}, child: const Text('Reset Wallet'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
