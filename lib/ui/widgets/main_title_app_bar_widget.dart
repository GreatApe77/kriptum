import 'package:flutter/material.dart';

class MainTitleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainTitleAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'K R I P T U M',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
