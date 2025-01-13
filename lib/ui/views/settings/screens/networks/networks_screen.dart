import 'package:flutter/material.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/views/settings/screens/networks/screens/add_network_screen.dart';

class NetworksScreen extends StatefulWidget {
  final NetworksController networksController;
  const NetworksScreen({super.key, required this.networksController});

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
      body: Padding(
        padding: AppSpacings.horizontalPadding,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Expanded(
                  child: ListenableBuilder(
                      listenable: widget.networksController,
                      builder: (context, child) {
                        return ListView.builder(
                          itemCount: widget.networksController.networks.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(widget.networksController.networks[index].name),
                          ),
                        );
                      })),
              ElevatedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNetworkScreen(networksController: widget.networksController),)), child: Text('Add Network'))
            ],
          ),
        ),
      ),
    );
  }
}
