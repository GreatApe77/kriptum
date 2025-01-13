import 'package:flutter/material.dart';
import 'package:kriptum/domain/models/network.dart';

class NetworkListTile extends StatelessWidget {
  final Network network;
  final Function() onNetworkTap;
  const NetworkListTile({super.key, required this.network, required this.onNetworkTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.public),
      title: GestureDetector(
        onTap: () => onNetworkTap(),
        child: Text(network.name)),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    );
  }
}
