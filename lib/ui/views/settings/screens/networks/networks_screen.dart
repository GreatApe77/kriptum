import 'package:flutter/material.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/networks_list.dart';
import 'package:kriptum/ui/views/settings/screens/networks/screens/add_network_screen.dart';

class NetworksScreen extends StatefulWidget {
  final NetworksController networksController;
  final SettingsController settingsController;
  final CurrentNetworkController currentNetworkController;
  const NetworksScreen({super.key, required this.networksController, required this.settingsController, required this.currentNetworkController});

  @override
  State<NetworksScreen> createState() => _NetworksScreenState();
}

class _NetworksScreenState extends State<NetworksScreen> {
  @override
  void initState() {
    super.initState();
    widget.networksController.loadNetworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Networks'),
      ),
      body: NetworksList(
        currentNetworkController: widget.currentNetworkController,
        settingsController: widget.settingsController,
        networksController: widget.networksController, onNetworkChooseSideEffect: () { 
          _onNetworkChooseSideEffect();
         },),
    );
  }
  void _onNetworkChooseSideEffect(){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Switched to ${widget.currentNetworkController.currentConnectedNetwork?.name}'))
    );
  }
}

