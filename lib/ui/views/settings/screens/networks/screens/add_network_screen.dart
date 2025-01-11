import 'package:flutter/material.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';

class AddNetworkScreen extends StatelessWidget {
  final NetworksController networksController;
  final formKey = GlobalKey<FormState>();
  AddNetworkScreen({super.key, required this.networksController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Network'),
      ),
      body: Padding(
        padding: AppSpacings.horizontalPadding,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text('Network Name'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text('RPC Url'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text('Chain ID'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text('Symbol'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text('Block Explorer URL'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(onPressed: () {
                    
                  }, child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
