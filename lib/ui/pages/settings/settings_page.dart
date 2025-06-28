import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/lock_wallet/lock_wallet_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/shared/utils/show_snack_bar.dart';
import 'package:kriptum/ui/app.dart';
import 'package:kriptum/ui/pages/contacts/contacts_page.dart';
import 'package:kriptum/ui/pages/general_settings/general_settings_page.dart';
import 'package:kriptum/ui/pages/networks/networks_page.dart';
import 'package:kriptum/ui/pages/settings/widgets/settings_submenu_card.dart';
import 'package:kriptum/ui/pages/splash/splash_page.dart';

class SettingsPage extends StatelessWidget {
  static final settingsPageNavigatorKey = GlobalKey<NavigatorState>();
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: settingsPageNavigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => const _SettingsView(),
        );
      },
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SettingsSubmenuCard(
            title: 'General',
            description: 'General settings like theming...',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GeneralSettingsPage(),
              ),
            ),
          ),
          SettingsSubmenuCard(
            title: 'Networks',
            description: 'Add and edit custom RPC networks',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NetworksPage(),
              ),
            ),
          ),
          SettingsSubmenuCard(
            title: 'Contacts',
            description: 'Add, edit, remove and manage your contacts',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ContactsPage(),
              ),
            ),
          ),
          BlocProvider<LockWalletBloc>(
            create: (context) => LockWalletBloc(injector.get()),
            child: BlocConsumer<LockWalletBloc, LockWalletState>(
              listener: (context, state) {
                if (state is LockWalletError) {
                  showSnackBar(
                    message: state.errorMessage,
                    context: context,
                    snackBarType: SnackBarType.error,
                  );
                }
                if (state is LockWalletSuccess) {
                  App.navigator.currentState?.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SplashPage(),
                    ),
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                //print(context.read<LockWalletBloc>().state);
                return ListTile(
                  title: Text(
                    'Lock Wallet',
                    style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  ),
                  onTap: () => context.read<LockWalletBloc>().add(LockWalletRequested()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
