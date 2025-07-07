import 'package:flutter/material.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/factories/ethereum_address/ethereum_address.dart';
import 'package:kriptum/ui/pages/scan_qr_code/scan_qr_code_page.dart';

class EthereumAddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final InputDecoration inputDecoration;
  const EthereumAddressTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.inputDecoration = const InputDecoration(),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) {
        final result = injector.get<EthereumAddressFactory>().create(value ?? '');
        if (result.isFailure) {
          return result.failure;
        }
        return null;
      },
      decoration: inputDecoration.copyWith(
        hintText: 'Public address (0x)',
        suffixIcon: readOnly
            ? null
            : IconButton(
                onPressed: () async {
                  final address = await Navigator.of(context).push<String>(
                    MaterialPageRoute(
                      builder: (context) => const ScanQrCodePage(),
                    ),
                  );
                  if (address != null) {
                    controller.text = address;
                  }
                },
                icon: Icon(Icons.qr_code),
              ),
      ),
    );
  }
}
