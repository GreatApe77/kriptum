import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/reset_wallet/reset_wallet_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/pages/splash/splash_page.dart';
import 'package:kriptum/ui/pages/unlock_wallet/widgets/erase_wallet_dialog.dart';

import 'package:kriptum/ui/tokens/spacings.dart';

class UnlockWalletPage extends StatelessWidget {
  const UnlockWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResetWalletBloc>(
          create: (context) => ResetWalletBloc(
            resetWalletUsecase: injector.get(),
          ),
        ),
      ],
      child: UnlockWalletView(),
    );
  }
}

class UnlockWalletView extends StatelessWidget {
  UnlockWalletView({
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
                TextButton(
                    onPressed: () => _showEraseWalletDialog(context),
                    child: const Text('Reset Wallet'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEraseWalletDialog(BuildContext context) {
    final bloc = context.read<ResetWalletBloc>();
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<ResetWalletBloc, ResetWalletState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ResetWalletSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SplashPage(),
                ),
                (route) => false,
              );
            } else if (state is ResetWalletFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return EraseWalletDialog(
              onCancel: () {
                Navigator.of(context).pop();
              },
              onContinue: () {
                bloc.add(ResetWalletRequested());
              },
              isLoading: state is ResetWalletInProgress,
            );
          },
        );
      },
    );
  }
}
