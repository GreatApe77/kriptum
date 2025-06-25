import 'package:flutter/material.dart';
import 'package:kriptum/ui/pages/send_native/widgets/choose_recipient_widget.dart';
import 'package:kriptum/ui/pages/send_native/widgets/page_title.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/ethereum_address_text_field.dart';

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
