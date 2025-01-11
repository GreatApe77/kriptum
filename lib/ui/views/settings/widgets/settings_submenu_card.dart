import 'package:flutter/material.dart';

class SettingsSubmenuCard extends StatelessWidget {
  final String title;
  final String description;

  final Function() onPressed;

  const SettingsSubmenuCard(
      {super.key,
      required this.title,
      required this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: ListTile(
        title: Text(title,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20
        ),),
        subtitle: Text(description),
        trailing: Icon( Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
