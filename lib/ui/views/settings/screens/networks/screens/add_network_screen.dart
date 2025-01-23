import 'package:flutter/material.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/network_validator_controller.dart';

class AddNetworkScreen extends StatelessWidget {
  final NetworksController networksController;
  final networkNameController = TextEditingController();
  final rpcUrlController = TextEditingController();
  final chainIdController = TextEditingController();
  final symbolController = TextEditingController(text: 'ETH');
  final blockExplorerNameController = TextEditingController();
  final blockExplorerUrlController = TextEditingController();
  final currencyDecimalsController = TextEditingController(text: '18');
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
                validator: (value) =>
                    NetworkValidatorController.validateName(value ?? ''),
                controller: networkNameController,
                decoration: const InputDecoration(
                    label: Text('Network Name'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) =>
                    NetworkValidatorController.validateRpcUrl(value ?? ''),
                controller: rpcUrlController,
                decoration: const InputDecoration(
                    label: Text('RPC Url'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) =>
                    NetworkValidatorController.validateChainId(value ?? ''),
                controller: chainIdController,
                decoration: const InputDecoration(
                    label: Text('Chain ID'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) =>
                    NetworkValidatorController.validateTicker(value ?? ''),
                controller: symbolController,
                decoration: const InputDecoration(
                    label: Text('Ticker'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) =>
                    NetworkValidatorController.validateBlockExplorerName(
                        value ?? '',
                        blockExplorerUrlController.text.isNotEmpty ||
                            blockExplorerNameController.text.isNotEmpty),
                controller: blockExplorerNameController,
                decoration: const InputDecoration(
                    label: Text('Block Explorer Name'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) =>
                    NetworkValidatorController.validateBlockExplorerUrl(
                        value ?? '',
                        blockExplorerUrlController.text.isNotEmpty ||
                            blockExplorerNameController.text.isNotEmpty),
                controller: blockExplorerUrlController,
                decoration: const InputDecoration(
                    label: Text('Block Explorer URL'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) =>
                    NetworkValidatorController.validateDecimals(value ?? ''),
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
                  FilledButton(
                      onPressed: () => _triggerAddNetwork(context),
                      child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _triggerAddNetwork(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;
    await networksController.addNetwork(
        onFail: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Already registered Network!'),
            backgroundColor: Theme.of(context).colorScheme.error,
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
