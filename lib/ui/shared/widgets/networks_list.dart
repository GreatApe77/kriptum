import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/network_list_tile.dart';
import 'package:kriptum/ui/views/settings/screens/networks/screens/add_network_screen.dart';

class NetworksList extends StatelessWidget {
  final NetworksController networksController;
  final SettingsController settingsController;
  final filterController = TextEditingController();

  NetworksList(
      {super.key,
      required this.networksController,
      required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.horizontalPadding,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: filterController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (value) {
                networksController.filterNetworks(value);
              },
            ),
            Expanded(
                child: ListenableBuilder(
                    listenable: networksController,
                    builder: (context, child) {
                      if (filterController.text.isNotEmpty) {
                        return ListView.builder(
                          itemCount: networksController.filteredList.length,
                          itemBuilder: (context, index) => NetworkListTile(
                              onNetworkTap: () => _onNetworkTap(index, context),
                              network: networksController.filteredList[index]),
                        );
                      }
                      return ListView.builder(
                        itemCount: networksController.networks.length,
                        itemBuilder: (context, index) => NetworkListTile(
                            onNetworkTap: () => _onNetworkTap(index, context),
                            network: networksController.networks[index]),
                      );
                    })),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNetworkScreen(
                          networksController: networksController),
                    )),
                child: const Text('Add Network'))
          ],
        ),
      ),
    );
  }

  void _onNetworkTap(int networkIndex, BuildContext context) async {
    await settingsController.changeLastConnectedNetworkId(
        networksController.networks[networkIndex].id!);
    await networksController.switchNetwork(
      networkIndex,
      onSuccess: ()  {
        Navigator.pop(context);
      },
    );
  }
}
