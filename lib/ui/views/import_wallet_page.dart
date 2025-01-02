import 'package:flutter/material.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';

class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTitleAppBar(),
    );
  }
}