import 'package:flutter/material.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/networks_list.dart';
import 'package:kriptum/ui/views/settings/screens/networks/screens/add_network_screen.dart';

class NetworksScreen extends StatefulWidget {
  final NetworksController networksController;
  final SettingsController settingsController;
  const NetworksScreen({super.key, required this.networksController, required this.settingsController});

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
        settingsController: widget.settingsController,
        networksController: widget.networksController),
    );
  }
}

