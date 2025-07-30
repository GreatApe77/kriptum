import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BalanceSkeleton extends StatelessWidget {
  const BalanceSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: Text('........'));
  }
}
