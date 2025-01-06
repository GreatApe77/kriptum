import 'package:flutter/material.dart';
import 'package:kriptum/controllers/connected_account_controller.dart';
import 'package:kriptum/ui/controllers/navigation_bar_controller.dart';

class HomePage extends StatefulWidget {
  final NavigationBarController navigationBarController;
  final ConnectedAccountController connectedAccountController;
  const HomePage(
      {super.key,
      required this.navigationBarController,
      required this.connectedAccountController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int currPage= 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.connectedAccountController.loadCurrentAccount();
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
          builder: (context,child) {
            return ListenableBuilder(
              listenable: widget.navigationBarController,
              builder: (context, child) {
                final pages = [
                  Center(
                      child: Text('PAGE: ${widget.navigationBarController.selectedPage} \n CURRENT ACCOUNT : ${
                        widget.connectedAccountController.connectedAccount?.address ?? 'NAO TEM'
                      }')),
                  Center(
                      child: Text('PAGE: ${widget.navigationBarController.selectedPage}')),
                  Center(
                      child: Text('PAGE: ${widget.navigationBarController.selectedPage}')),
                  Center(
                      child: Text('PAGE: ${widget.navigationBarController.selectedPage}')),
                  Center(
                      child: Text('PAGE: ${widget.navigationBarController.selectedPage}')),
                ];
                return pages[widget.navigationBarController.selectedPage];
              },
            );
          }
        ));
  }
}
