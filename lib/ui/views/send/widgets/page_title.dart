
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String networkName;
  const PageTitle({
    Key? key,
    required this.title,
    required this.networkName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        Text(
          networkName,
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
