import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeWidget extends StatefulWidget {
  const ScanQrCodeWidget({super.key});

  @override
  State<ScanQrCodeWidget> createState() => _ScanQrCodeWidgetState();
}

class _ScanQrCodeWidgetState extends State<ScanQrCodeWidget> {
  bool _scanned = false;
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (result) {
        if (!_scanned) {
          _scanned = true;
          final address = result.barcodes.first.rawValue;
          Navigator.of(context).pop<String>(address);
        }
      },
    );
  }
}
