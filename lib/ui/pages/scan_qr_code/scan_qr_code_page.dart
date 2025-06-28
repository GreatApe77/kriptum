import 'package:flutter/material.dart';
import 'package:kriptum/ui/pages/receive/receive_page.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/scan_qr_code_widget.dart';

class ScanQrCodePage extends StatelessWidget {
  const ScanQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.horizontalPadding,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scan QR Code',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text('Use your camera to scan a QR code'),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SegmentedButton(
                      onSelectionChanged: (p0) {
                        if (p0.isEmpty) return;
                        if (p0.first == 2) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ReceivePage(),
                            ),
                          );
                        }
                      },
                      segments: const [
                        ButtonSegment<int>(value: 1, label: Text('Scan QR code')),
                        ButtonSegment<int>(value: 2, label: Text('Your QR code'))
                      ],
                      selected: const {
                        1
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ScanQrCodeWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
