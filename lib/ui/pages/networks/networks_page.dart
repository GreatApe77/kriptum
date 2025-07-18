import 'package:flutter/material.dart';
import 'package:kriptum/shared/utils/show_snack_bar.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/networks_list.dart';

class NetworksPage extends StatelessWidget {
  const NetworksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NetworksView();
  }
}

class _NetworksView extends StatelessWidget {
  const _NetworksView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Networks'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacings.horizontalPadding,
        ),
        child: NetworksList(
          onNetworkChosen: (network) {
            showSnackBar(
              message: 'Network changed to ${network.name}.',
              context: context,
            );
          },
        ),
      ),
    );
  }
}
