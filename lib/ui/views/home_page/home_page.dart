import 'package:flutter/material.dart';
import 'package:kriptum/controllers/accounts_controller.dart.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/ui/views/home_page/controllers/navigation_bar_controller.dart';
import 'package:kriptum/ui/views/home_page/screens/settings_screen.dart';
import 'package:kriptum/ui/views/home_page/screens/wallet_screen.dart';

class HomePage extends StatefulWidget {
  final NavigationBarController navigationBarController;
  final AccountsController connectedAccountController;
  final SettingsController settingsController;
  const HomePage(
      {super.key,
      required this.navigationBarController,
      required this.connectedAccountController,
      required this.settingsController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int currPage= 0;

  @override
  void initState() {
    super.initState();
    widget.connectedAccountController.loadCurrentAccount(
        widget.settingsController.settings.lastConnectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ListenableBuilder(
          listenable: widget.navigationBarController,
          builder: (BuildContext context, Widget? child) {
            return NavigationBar(
              animationDuration: Duration(seconds: 1),
              onDestinationSelected: (value) {
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
                    icon: Icon(Icons.compare_arrows), label: ''),
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
            listenable: widget.connectedAccountController,
            builder: (context, child) {
              return ListenableBuilder(
                listenable: widget.navigationBarController,
                builder: (context, child) {
                  final pages = [
                    // Center(
                    //     child: Text(
                    //         'PAGE: ${widget.navigationBarController.selectedPage} \n CURRENT ACCOUNT : ${widget.connectedAccountController.connectedAccount?.address ?? 'NAO TEM'}')),
                    WalletScreen(
                      settingsController: widget.settingsController,
                      accountsController: widget.connectedAccountController,
                    ),
                    Center(
                        child: Text(
                            'PAGE: ${widget.navigationBarController.selectedPage}')),
                    Center(
                        child: Text(
                            'PAGE: ${widget.navigationBarController.selectedPage}')),
                    Center(
                        child: Text(
                            'PAGE: ${widget.navigationBarController.selectedPage}')),
                    SettingsScreen(
                        settingsController: widget.settingsController),
                  ];
                  return pages[widget.navigationBarController.selectedPage];
                },
              );
            }));
  }
}
