import 'package:flutter/material.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';

class CreatePasswordStep1Screen extends StatelessWidget {
  final CreateWalletStepsController _createWalletStepsController;
  const CreatePasswordStep1Screen({
    super.key,
    required CreateWalletStepsController stepController,
  }) : _createWalletStepsController = stepController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create password PAGE: ${_createWalletStepsController.step}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'This password will unlock your Kriptum wallet only on this device',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                label: Text('New Password'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                helperText: 'Must be at leaset 8 characters',
                label: Text('Confirm Password'),
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 24,
          ),
          ElevatedButton(onPressed: () {
            _createWalletStepsController.nextStep();
          }, child: Text('Create password'))
        ],
      ),
    );
  }
}
