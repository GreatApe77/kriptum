import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/create_new_wallet/create_new_wallet_bloc.dart';
import 'package:kriptum/ui/widgets/linear_check_in_progress_bar_widget.dart';

class CreatePasswordWidget extends StatelessWidget {
  const CreatePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        //key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearCheckInProgressBar(
              currentDot: 1,
              //currentDot: _createWalletStepsController.step + 1,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Create password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'This password will unlock your Kriptum wallet only on this device',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              // controller: passwordTextController,
              // validator: (password) =>
              //     PasswordValidatorController.validLength(password),
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text('New Password'), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              // controller: confirmPasswordTextController,
              //validator: (confirmPassword) =>
              // PasswordValidatorController.validLength(confirmPassword),
              obscureText: true,
              decoration: const InputDecoration(
                  helperText: 'Must be at leaset 8 characters',
                  label: Text('Confirm Password'),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 24,
            ),
            FilledButton(
                onPressed: () {
                  context.read<CreateNewWalletBloc>().add(
                        AdvanceToStep2Event(),
                      );
                },
                //onPressed: () => _triggerCreateWallet(context),
                child: const Text('Create Wallet')),
          ],
        ),
      ),
    );
  }
}
