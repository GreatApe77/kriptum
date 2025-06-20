import 'package:flutter/material.dart';

import 'package:kriptum/domain/models/network.dart';

class NetworkListTile extends StatelessWidget {
  final Network network;
  final Function(Network network) onNetworkTap;
  final bool selected;
  const NetworkListTile({
    super.key,
    required this.network,
    required this.onNetworkTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      leading: const Icon(Icons.public),
      onTap: () => onNetworkTap(network),
      title: Text(network.name),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    );
  }
}
