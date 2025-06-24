import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeWidget extends StatelessWidget {
  const ScanQrCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (result) {
        final address = result.barcodes.first.rawValue;
        //print('Scanned address: $address');
        return Navigator.of(context).pop<String>(address);
      },
    );
  }
}
