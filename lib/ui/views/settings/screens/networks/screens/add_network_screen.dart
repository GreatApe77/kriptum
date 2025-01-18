import 'package:flutter/material.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';

class AddNetworkScreen extends StatelessWidget {
  final NetworksController networksController;
  final networkNameController = TextEditingController();
  final rpcUrlController = TextEditingController();
  final chainIdController = TextEditingController();
  final symbolController = TextEditingController();
  final blockExplorerNameController = TextEditingController();
  final blockExplorerUrlController = TextEditingController();
  final currencyDecimalsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AddNetworkScreen({super.key, required this.networksController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Network'),
      ),
      body: Padding(
        padding: AppSpacings.horizontalPadding,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: networkNameController,
                decoration: const InputDecoration(
                    label: Text('Network Name'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: rpcUrlController,
                decoration: const InputDecoration(
                    label: Text('RPC Url'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: chainIdController,
                decoration: const InputDecoration(
                    label: Text('Chain ID'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: symbolController,
                decoration: const InputDecoration(
                    label: Text('Symbol'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: blockExplorerNameController,
                decoration: const InputDecoration(
                    label: Text('Block Explorer Name'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller:blockExplorerUrlController,

                decoration: const InputDecoration(
                    label: Text('Block Explorer URL'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: currencyDecimalsController,
                decoration: const InputDecoration(
                    label: Text('Currency Decimals'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(onPressed: 
                  () => _triggerAddNetwork(context), child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _triggerAddNetwork(BuildContext context) async {
    await networksController.addNetwork(
        onFail: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: const Text('Already registered Network!'),
            backgroundColor:Theme.of(context).colorScheme.error,
            showCloseIcon: true,
          ));
        },
        onSuccess: () {
          Navigator.pop(context);
        },
        id: int.parse(chainIdController.text),
        name: networkNameController.text,
        rpcUrl: rpcUrlController.text,
        ticker: symbolController.text,
        blockExplorerName: blockExplorerNameController.text,
        blockExplorerUrl: blockExplorerUrlController.text,
        currencyDecimals: int.parse(currencyDecimalsController.text));
  }
}
