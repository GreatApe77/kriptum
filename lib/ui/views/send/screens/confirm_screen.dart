import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/views/send/widgets/page_title.dart';

class ConfirmScreen extends StatelessWidget {
  final CurrentNetworkController currentNetworkController;
  const ConfirmScreen({super.key, required this.currentNetworkController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Back'),
        ),
        title: PageTitle(
            title: 'Confirm',
            networkName:
                currentNetworkController.currentConnectedNetwork!.name),
      actions: [
          TextButton(
              onPressed: () {},
              child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRoutes.home);
                  },
                  child: Text('Cancel')))
        ],
      ),
    );
  }
}
