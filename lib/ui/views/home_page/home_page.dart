import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.timer)),
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.compare_arrows)),
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.settings)),
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
          NavigationDestination(
            icon: Icon(Icons.wallet), label: ''),
          NavigationDestination(icon: Icon(Icons.timer), label: ''),
          NavigationDestination(icon: Icon(Icons.compare_arrows), label: ''),
          NavigationDestination(icon: Icon(Icons.screen_search_desktop_sharp), label: ''),
          NavigationDestination(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      //   items: const [
      //   BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
      //   BottomNavigationBarItem(label: '', icon: Icon(Icons.timer)),
      //   BottomNavigationBarItem(
      //       label: '', icon: Icon(Icons.compare_arrows)),
      //   BottomNavigationBarItem(label: '', icon: Icon(Icons.settings)),
      //   BottomNavigationBarItem(label: '', icon: Icon(Icons.wallet)),
      // ]),
      body: const Center(
        child: Text('HOME'),
      ),
    );
  }
}
