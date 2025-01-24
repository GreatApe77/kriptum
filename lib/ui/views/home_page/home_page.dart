import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/accounts/accounts_controller.dart';
import 'package:kriptum/controllers/accounts/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/password_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/views/home_page/controllers/navigation_bar_controller.dart';
import 'package:kriptum/ui/views/home_page/screens/wallet_screen.dart';

class HomePage extends StatefulWidget {
  final PasswordController passwordController;
  final NavigationBarController navigationBarController;
  final AccountsController accountsController;
  final SettingsController settingsController;
  final AccountBalanceController accountBalanceController;
  final NetworksController networksController;
  final CurrentNetworkController currentNetworkController;
  final CurrentAccountController currentAccountController;
  const HomePage(
      {super.key,
      required this.navigationBarController,
      required this.accountsController,
      required this.settingsController,
      required this.accountBalanceController,
      required this.networksController,
      required this.currentNetworkController,
      required this.currentAccountController,
      required this.passwordController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int currPage= 0;

  @override
  void initState() {
    super.initState();
    widget.currentAccountController.loadCurrentAccount(
        widget.settingsController.settings.lastConnectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ListenableBuilder(
          listenable: widget.navigationBarController,
          builder: (BuildContext context, Widget? child) {
            return NavigationBar(
              animationDuration: const Duration(seconds: 1),
              onDestinationSelected: (value) async {
                if (value == 2) {
                  //open sendOrReceiveTransactionModal
                  await showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Navigator.pop(context);
                                GoRouter.of(context).push(AppRoutes.send);
                              },
                              child: const ListTile(
                                leading: Icon(Icons.arrow_outward_rounded),
                                title: Text('Send'),
                                subtitle: Text('Send crypto to any account'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                GoRouter.of(context).push(AppRoutes.receive);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: const ListTile(
                                leading: Icon(Icons.call_received_rounded),
                                title: Text('Receive'),
                                subtitle: Text('Receive crypto'),
                              ),
                            ),
                          ],
                        )),
                  );
                  return;
                }

                if (value == 4) {
                  GoRouter.of(context).push(AppRoutes.settings);
                  return;
                }
                widget.navigationBarController.navigateToScreen(value);
              },
              selectedIndex: widget.navigationBarController.selectedPage,
              destinations: const [
                // BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
                // BottomNavigationBarItem(label: '', icon: Icon(Icons.timer)),
                // BottomNavigationBarItem(label: '', icon: Icon(Icons.compare_arrows)),
                // BottomNavigationBarItem(label: '', icon: Icon(Icons.settings)),
                // BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
                NavigationDestination(icon: Icon(Icons.wallet), label: ''),
                NavigationDestination(
                  icon: Icon(Icons.timer),
                  label: '',
                ),
                NavigationDestination(
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    label: ''),
                NavigationDestination(
                    icon: Icon(Icons.screen_search_desktop_sharp), label: ''),
                NavigationDestination(icon: Icon(Icons.settings), label: ''),
              ],
            );
          },
        ),
        //   items: const [
        //   BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
        //   BottomNavigationBarItem(label: '', icon: Icon(Icons.timer)),
        //   BottomNavigationBarItem(
        //       label: '', icon: Icon(Icons.compare_arrows)),
        //   BottomNavigationBarItem(label: '', icon: Icon(Icons.settings)),
        //   BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
        // ]),
        body: ListenableBuilder(
          listenable: widget.navigationBarController,
          builder: (context, child) {
            final pages = [
              // Center(
              //     child: Text(
              //         'PAGE: ${widget.navigationBarController.selectedPage} \n CURRENT ACCOUNT : ${widget.connectedAccountController.connectedAccount?.address ?? 'NAO TEM'}')),
              WalletScreen(
                passwordController: widget.passwordController,
                currentAccountController: widget.currentAccountController,
                currentNetworkController: widget.currentNetworkController,
                networksController: widget.networksController,
                settingsController: widget.settingsController,
                accountsController: widget.accountsController,
                accountBalanceController: widget.accountBalanceController,
              ),
              const Center(child: Text('Coming soon...')),
              Container(),
              const Center(child: Text('Coming soon...')),
              //SettingsScreen(
              //    settingsController: widget.settingsController),
            ];
            return pages[widget.navigationBarController.selectedPage];
          },
        ));
  }
}
