import 'package:flutter/material.dart';
import 'package:kriptum/ui/controllers/navigation_bar_controller.dart';

class HomePage extends StatelessWidget {
  final NavigationBarController navigationBarController;
  const HomePage({super.key, required this.navigationBarController});

  //int currPage= 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ListenableBuilder(
          listenable: navigationBarController,
          builder: (BuildContext context, Widget? child) {
            return NavigationBar(
              animationDuration: Duration(seconds: 1),
              onDestinationSelected: (value) {
                navigationBarController.navigateToScreen(value);
              },
              selectedIndex: navigationBarController.selectedPage,
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
          listenable: navigationBarController,
          builder: (context, child) {
            final pages = [
              Center(
                  child: Text('PAGE: ${navigationBarController.selectedPage}')),
              Center(
                  child: Text('PAGE: ${navigationBarController.selectedPage}')),
              Center(
                  child: Text('PAGE: ${navigationBarController.selectedPage}')),
              Center(
                  child: Text('PAGE: ${navigationBarController.selectedPage}')),
              Center(
                  child: Text('PAGE: ${navigationBarController.selectedPage}')),
            ];
            return pages[navigationBarController.selectedPage];
          },
        ));
  }
}
