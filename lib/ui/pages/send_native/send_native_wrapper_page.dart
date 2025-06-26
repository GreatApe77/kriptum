import 'package:flutter/material.dart';
import 'package:kriptum/ui/pages/send_native/widgets/choose_recipient_widget.dart';

class SendNativeWrapperPage extends StatefulWidget {
  const SendNativeWrapperPage({super.key});

  @override
  State<SendNativeWrapperPage> createState() => _SendNativeWrapperPageState();
}

class _SendNativeWrapperPageState extends State<SendNativeWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return ChooseRecipientWidget();
  }
}
