import 'package:flutter/material.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('K R I P T U M',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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

              onPressed: () {}, child: const Text('Import using Secret Recovery Phrase')),
            const SizedBox(height: 8,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                
              ),
              onPressed: () {}, child: const Text('Create a new wallet')),
            const SizedBox(height: 42,),
          ],
        ),
      ),
    );
  }
}
